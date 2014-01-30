require 'spec_helper'

describe Viagogo::Public::API::Venues do
  before do
    @client = Viagogo::Public::Client.new(:consumer_key => 'CK',
                                          :consumer_secret => 'CS',
                                          :access_token => 'AT',
                                          :access_token_secret => 'AS')
  end

  describe "#venue" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.venue 1
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = 50
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get("/Public/Venue/#{expected_resource}").
          with(:query => expected_params).
          to_return(:body => "{}")
      @client.venue expected_resource, expected_params
      expect(a_get("/Public/Venue/#{expected_resource}").with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Venue created from the response" do
      stub_get("/Public/Venue/1").to_return({:body => fixture("venue.json")})
      expect(@client.venue 1).to be_an_instance_of(Viagogo::Venue)
    end
  end

  describe "#venues_by_metro_area" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.venues_by_metro_area 2
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = "/Public/Venue/ByMetroArea/50"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get(expected_resource).with(:query => expected_params).to_return(:body => "{}")
      @client.venues_by_metro_area 50, expected_params
      expect(a_get(expected_resource).with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Page created from the response" do
      stub_request(:any, /.*/).to_return(:body => fixture("venues.json"))
      expect(@client.venues_by_metro_area 20).to be_an_instance_of(Viagogo::Page)
    end
  end
end
