require 'spec_helper'

describe Viagogo::Public::API::Geographies do
  before do
    @client = Viagogo::Public::Client.new(:consumer_key => 'CK',
                                          :consumer_secret => 'CS',
                                          :access_token => 'AT',
                                          :access_token_secret => 'AS')
  end

  describe "#geography" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.geography 1
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = 50
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get("/Public/Geography/#{expected_resource}").
          with(:query => expected_params).
          to_return(:body => "{}")
      @client.geography expected_resource, expected_params
      expect(a_get("/Public/Geography/#{expected_resource}").with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Geography created from the response" do
      stub_get("/Public/Geography/1").to_return({:body => "{\"Id\": 5}"})
      expect(@client.geography 1).to be_an_instance_of(Viagogo::Geography)
    end
  end

  describe "#geographies" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.geographies
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = "/Public/Geography/All"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get(expected_resource).with(:query => expected_params).to_return(:body => "{}")
      @client.geographies expected_params
      expect(a_get(expected_resource).with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Page created from the response" do
      stub_get("/Public/Geography/All").to_return({:body => "{}"})
      expect(@client.geographies).to be_an_instance_of(Viagogo::Page)
    end
  end
end
