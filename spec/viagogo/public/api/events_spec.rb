require 'spec_helper'

describe Viagogo::Public::API::Events do
  before do
    @client = Viagogo::Public::Client.new(:consumer_key => 'CK',
                                          :consumer_secret => 'CS',
                                          :access_token => 'AT',
                                          :access_token_secret => 'AS')
  end

  describe "#event" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.event 1
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = 50
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get("/Public/Event/#{expected_resource}").
          with(:query => expected_params).
          to_return(:body => "{}")
      @client.event expected_resource, expected_params
      expect(a_get("/Public/Event/#{expected_resource}").with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Event created from the response" do
      stub_get("/Public/Event/1").to_return({:body => fixture("event.json")})
      expect(@client.event 1).to be_an_instance_of(Viagogo::Event)
    end
  end

  describe "#events_by_category" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.events_by_category 2
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = "/Public/Event/ByCategory/50"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get(expected_resource).with(:query => expected_params).to_return(:body => "{}")
      @client.events_by_category 50, expected_params
      expect(a_get(expected_resource).with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Page created from the response" do
      stub_request(:any, /.*/).to_return(:body => fixture("events.json"))
      expect(@client.events_by_category 20).to be_an_instance_of(Viagogo::Page)
    end
  end

  describe "#events_by_metro_area" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.events_by_metro_area 2
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = "/Public/Event/ByMetroArea/50"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get(expected_resource).with(:query => expected_params).to_return(:body => "{}")
      @client.events_by_metro_area 50, expected_params
      expect(a_get(expected_resource).with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Page created from the response" do
      stub_request(:any, /.*/).to_return(:body => fixture("events.json"))
      expect(@client.events_by_metro_area 20).to be_an_instance_of(Viagogo::Page)
    end
  end

  describe "#events_by_venue" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.events_by_venue 2
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = "/Public/Event/ByVenue/50"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get(expected_resource).with(:query => expected_params).to_return(:body => "{}")
      @client.events_by_venue 50, expected_params
      expect(a_get(expected_resource).with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Page created from the response" do
      stub_request(:any, /.*/).to_return(:body => fixture("events.json"))
      expect(@client.events_by_venue 20).to be_an_instance_of(Viagogo::Page)
    end
  end

  describe "#events_by_utc_start_date" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.events_by_utc_start_date 2000, 1, 1
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = "/Public/Event/ByUtcStartDate/2003/3/15"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get(expected_resource).with(:query => expected_params).to_return(:body => "{}")
      @client.events_by_utc_start_date 2003, 3, 15, expected_params
      expect(a_get(expected_resource).with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Page created from the response" do
      stub_request(:any, /.*/).to_return(:body => fixture("events.json"))
      expect(@client.events_by_utc_start_date 2011, 11, 11).to be_an_instance_of(Viagogo::Page)
    end
  end

  describe "#events_search" do
    it "makes HTTP get request" do
      stub_request(:any, /.*/).to_return(:body => "{}")
      @client.events_search "foo"
      expect(a_request(:get, /.*/)).to have_been_made
    end

    it "makes request for the correct resource" do
      expected_resource = "/Public/Event/Search"
      expected_params = {:searchText => "some query", :foo => "foo", :bar => "bar"}
      stub_get(expected_resource).with(:query => expected_params).to_return(:body => "{}")
      @client.events_search expected_params[:searchText], expected_params
      expect(a_get(expected_resource).with(:query => expected_params)).to have_been_made
    end

    it "returns Viagogo::Page created from the response" do
      stub_request(:any, /.*/).to_return(:body => fixture("events.json"))
      expect(@client.events_search "foo").to be_an_instance_of(Viagogo::Page)
    end
  end
end
