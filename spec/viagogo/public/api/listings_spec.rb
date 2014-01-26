require 'spec_helper'

describe Viagogo::Public::API::Listings do
  before do
    @client = Viagogo::Public::Client.new(:consumer_key => 'CK',
                                          :consumer_secret => 'CS',
                                          :access_token => 'AT',
                                          :access_token_secret => 'AS')
  end

  describe "#listing" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.listing 1
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = 50
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get("/Public/Listing/#{expected_resource}").
          with(:query => expected_params).
          to_return(:body => "{}")
      @client.listing expected_resource, expected_params
      expect(a_get("/Public/Listing/#{expected_resource}").with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Listing created from the response" do
      stub_get("/Public/Listing/1").to_return({:body => "{\"Id\": 5}"})
      expect(@client.listing 1).to be_an_instance_of(Viagogo::Listing)
    end
  end

  describe "#listings_by_event" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.listings_by_event 2
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = "/Public/Listing/ByEvent/50"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get(expected_resource).with(:query => expected_params).to_return(:body => "{}")
      @client.listings_by_event 50, expected_params
      expect(a_get(expected_resource).with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Page created from the response" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      expect(@client.listings_by_event 20).to be_an_instance_of(Viagogo::Page)
    end
  end
end
