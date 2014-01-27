require 'spec_helper'

describe Viagogo::Public::API::Categories do
  before do
    @client = Viagogo::Public::Client.new(:consumer_key => 'CK',
                                          :consumer_secret => 'CS',
                                          :access_token => 'AT',
                                          :access_token_secret => 'AS')
  end

  describe "#category" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.category 1
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = 50
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get("/Public/Category/#{expected_resource}").
          with(:query => expected_params).
          to_return(:body => "{}")
      @client.category expected_resource, expected_params
      expect(a_get("/Public/Category/#{expected_resource}").with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Category created from the response" do
      stub_get("/Public/Category/1").to_return({:body => "{\"Id\": 5 \"Parents\": []}"})
      expect(@client.category 1).to be_an_instance_of(Viagogo::Category)
    end
  end

  describe "#categories_top" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.categories_top "US"
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = "/Public/Category/AD/Top"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get(expected_resource).with(:query => expected_params).to_return(:body => "{}")
      @client.categories_top "AD", expected_params
      expect(a_get(expected_resource).with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Page created from the response" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      expect(@client.categories_top "GB").to be_an_instance_of(Viagogo::Page)
    end
  end

  describe "#categories_parents" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.categories_parents "US", 501
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = "/Public/Category/GB/Parents/21"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get(expected_resource).with(:query => expected_params).to_return(:body => "{}")
      @client.categories_parents "GB", 21, expected_params
      expect(a_get(expected_resource).with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Page created from the response" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      expect(@client.categories_parents "GB", 0).to be_an_instance_of(Viagogo::Page)
    end
  end

  describe "#categories_children" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.categories_children "US", 501
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = "/Public/Category/GB/Children/21"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get(expected_resource).with(:query => expected_params).to_return(:body => "{}")
      @client.categories_children "GB", 21, expected_params
      expect(a_get(expected_resource).with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Page created from the response" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      expect(@client.categories_children "GB", 0).to be_an_instance_of(Viagogo::Page)
    end
  end
end
