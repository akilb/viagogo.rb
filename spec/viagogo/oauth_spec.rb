require 'spec_helper'

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

    it "uses a */* Accept header" do
      stub_request(:any, /.*/).with(:headers => {:accept => '*/*'})
      @client.public_access_token
      expect(a_request(:any, /.*/).with(:headers => {:accept => '*/*'})).to have_been_made
    end

    context "when :scope is supplied" do
      it "passes the :scope as a query parameter" do
        expected_scope = "my scope"
        stub_request(:any, /.*/).with(:query => {"scope" => expected_scope})
        Viagogo::Client.new(:scope => expected_scope).public_access_token
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
  end
end
