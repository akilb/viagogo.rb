require 'spec_helper'

describe Viagogo::Public::API::MetroAreas do
  before do
    @client = Viagogo::Public::Client.new(:consumer_key => 'CK',
                                          :consumer_secret => 'CS',
                                          :access_token => 'AT',
                                          :access_token_secret => 'AS')
  end

  describe "#metro_area" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.metro_area 1
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = 50
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get("/Public/MetroArea/#{expected_resource}").
          with(:query => expected_params).
          to_return(:body => "{}")
      @client.metro_area expected_resource, expected_params
      expect(a_get("/Public/MetroArea/#{expected_resource}").with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::MetroArea created from the response" do
      stub_get("/Public/MetroArea/1").to_return({:body => "{\"Id\": 5}"})
      expect(@client.metro_area 1).to be_an_instance_of(Viagogo::MetroArea)
    end
  end

  describe "#metro_areas" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.metro_areas
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = "/Public/MetroArea/All"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get(expected_resource).with(:query => expected_params).to_return(:body => "{}")
      @client.metro_areas expected_params
      expect(a_get(expected_resource).with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Page created from the response" do
      stub_get("/Public/MetroArea/All").to_return({:body => "{}"})
      expect(@client.metro_areas).to be_an_instance_of(Viagogo::Page)
    end
  end
end
