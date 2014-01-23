require 'spec_helper'
require 'timecop'

describe Viagogo::OAuth do
  before do
    @client = Viagogo::Client.new(:consumer_key => 'CK', :consumer_secret => 'CS')
  end

  describe "#public_access_token" do
    it "makes a request to the public authentication url" do
      expected_path = "/Public/SimpleOAuthAccessRequest"
      stub_get(expected_path).with(:query => hash_including())
      @client.public_access_token
      expect(a_get(expected_path).with(:query => hash_including())).to have_been_made
    end

    context "when :scope is supplied" do
      it "passes the :scope as a query parameter" do
        expected_scope = "my scope"
        stub_request(:any, /.*/).with(:query => {"scope" => expected_scope})
        @client.public_access_token(expected_scope)
        expect(a_request(:any, /.*/).with(:query => {"scope" => expected_scope})).to have_been_made
      end
    end

    context "when :scope is not supplied" do
      it "passes the API.Public as a query parameter" do
        expected_scope = "API.Public"
        stub_request(:any, /.*/).with(:query => {"scope" => expected_scope})
        @client.public_access_token
        expect(a_request(:any, /.*/).with(:query => {"scope" => expected_scope})).to have_been_made
      end
    end

    it "returns a Viagogo::Token" do
      stub_request(:any, /.*/)
      access_token = @client.public_access_token
      expect(access_token).to be_an_instance_of(Viagogo::Token)
    end

    it "returns Viagogo::Token with given scope" do
      expected_scope = "my scope"
      stub_request(:any, /.*/)
      access_token = @client.public_access_token(expected_scope)
      expect(access_token.scope).to eq(expected_scope)
    end

    it "returns Viagogo::Token of access token type" do
      stub_request(:any, /.*/)
      access_token = @client.public_access_token
      expect(access_token.type).to eq("access token")
    end

    it "returns Viagogo::Token with :issue_timestamp set to now" do
      expected_issue_timestamp = Timecop.freeze(Time.new(2014, 1, 22, 14, 5, 30, '+00:00'))
      stub_request(:any, /.*/)
      access_token = @client.public_access_token
      Timecop.return
      expect(access_token.issue_timestamp).to eq(expected_issue_timestamp)
    end

    it "returns Viagogo::Token with :expiry_timestamp set 24 hours from now" do
      expected_expiry_timestamp = Time.new(2014, 1, 22, 14, 5, 0, '+00:00')
      Timecop.freeze(expected_expiry_timestamp - (24 * 60 * 60))
      stub_request(:any, /.*/)
      access_token = @client.public_access_token
      Timecop.return
      expect(access_token.expiry_timestamp).to eq(expected_expiry_timestamp)
    end

    it "returns Viagogo::Token of with :oauth_token from response" do
      stub_request(:any, /.*/).to_return(:body => "oauth_token=encoded%2Btoken%3D&oauth_token_secret=secret")
      access_token = @client.public_access_token
      expect(access_token.oauth_token).to eq("encoded+token=")
    end

    it "returns Viagogo::Token of with :oauth_token_secret from response" do
      stub_request(:any, /.*/).to_return(:body => "oauth_token=encoded%2Btoken%3D&oauth_token_secret=encoded%2Btoken%2Fsecret%3D")
      access_token = @client.public_access_token
      expect(access_token.oauth_token_secret).to eq("encoded+token/secret=")
    end
  end
end
