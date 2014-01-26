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
      stub_get("/Public/Country/GB").to_return({:body => "{\"name\":\"GB\"}"})
      expect(@client.country "GB").to be_an_instance_of(Viagogo::Country)
    end
  end
end
