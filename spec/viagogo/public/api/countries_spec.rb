require 'spec_helper'

describe Viagogo::Public::API::Countries do
  before do
    @client = Viagogo::Public::Client.new(:consumer_key => 'CK',
                                          :consumer_secret => 'CS',
                                          :access_token => 'AT',
                                          :access_token_secret => 'AS')
  end

  describe "#country" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.country "BB"
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = "US"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get("/Public/Country/#{expected_resource}").
          with(:query => expected_params).
          to_return(:body => "{}")
      @client.country expected_resource, expected_params
      expect(a_get("/Public/Country/#{expected_resource}").with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Country created from the response" do
      stub_get("/Public/Country/GB").to_return({:body => fixture("country.json")})
      expect(@client.country "GB").to be_an_instance_of(Viagogo::Country)
    end
  end

  describe "#countries" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.countries
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = "/Public/Country/All"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get(expected_resource).with(:query => expected_params).to_return(:body => "{}")
      @client.countries expected_params
      expect(a_get(expected_resource).with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Page created from the response" do
      stub_get("/Public/Country/All").to_return({:body => fixture("countries.json")})
      expect(@client.countries).to be_an_instance_of(Viagogo::Page)
    end
  end
end
