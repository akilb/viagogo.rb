require 'spec_helper'

describe Viagogo::Client do

  before do
    @client = Viagogo::Client.new(:consumer_key => 'CK',
                                  :consumer_secret => 'CS',
                                  :access_token => 'AT',
                                  :access_token_secret => 'AS')
  end

  describe "#new" do
    it "returns a Viagogo::Client object" do
      client = Viagogo::Client.new(:consumer_key => "CK", :consumer_secret => "CS")
      expect(client).to be_an_instance_of Viagogo::Client
    end

    context "when options are given" do
      it "sets consumer_key to given value" do
        expected_consumer_key = "my key"
        client = Viagogo::Client.new(:consumer_key => expected_consumer_key)
        expect(client.consumer_key).to eq(expected_consumer_key)
      end

      it "sets consumer_secret to given value" do
        expected_consumer_secret = "my secret"
        client = Viagogo::Client.new(:consumer_secret => expected_consumer_secret)
        expect(client.consumer_secret).to eq(expected_consumer_secret)
      end

      it "sets access_token to given value" do
        expected_access_token = "my access token"
        client = Viagogo::Client.new(:access_token => expected_access_token)
        expect(client.access_token).to eq(expected_access_token)
      end

      it "sets access_token_secret to given value" do
        expected_access_token_secret = "my access token secret"
        client = Viagogo::Client.new(:access_token_secret => expected_access_token_secret)
        expect(client.access_token_secret).to eq(expected_access_token_secret)
      end

      it "sets scope to given value" do
        expected_scope = "my scope"
        client = Viagogo::Client.new(:scope => expected_scope)
        expect(client.scope).to eq(expected_scope)
      end

      it "raises Viagogo::Error::ConfigurationError when :consumer_key is invalid" do
        expect { Viagogo::Client.new(:consumer_key => [50, 1]) }.to raise_error Viagogo::Error::ConfigurationError
      end

      it "raises Viagogo::Error::ConfigurationError when :consumer_secret is invalid" do
        expect { Viagogo::Client.new(:consumer_secret => [3, 'A']) }.to raise_error Viagogo::Error::ConfigurationError
      end

      it "raises Viagogo::Error::ConfigurationError when :access_token is invalid" do
        expect { Viagogo::Client.new(:access_token => [3, 'A']) }.to raise_error Viagogo::Error::ConfigurationError
      end

      it "raises Viagogo::Error::ConfigurationError when :access_token_secret is invalid" do
        expect { Viagogo::Client.new(:access_token_secret => [3, 'A']) }.to raise_error Viagogo::Error::ConfigurationError
      end

      it "raises Viagogo::Error::ConfigurationError when :scope is invalid" do
        expect { Viagogo::Client.new(:scope => [3, 'A']) }.to raise_error Viagogo::Error::ConfigurationError
      end
    end

    context "when block is given" do
      it "passes the current instance to be configured in the block" do
        actual_client = nil
        expected_client = Viagogo::Client.new do |config|
          config.consumer_key = "CK"
          config.consumer_secret = "CS"
          actual_client = config
        end

        expect(actual_client.object_id).to equal(expected_client.object_id)
      end

      it "raises Viagogo::Error::ConfigurationError when :consumer_key is invalid" do
        expect { Viagogo::Client.new do |config|
          config.consumer_key = 50
        end }.to raise_error Viagogo::Error::ConfigurationError
      end

      it "raises Viagogo::Error::ConfigurationError when :consumer_secret is invalid" do
        expect { Viagogo::Client.new do |config|
          config.consumer_secret = 6
        end }.to raise_error Viagogo::Error::ConfigurationError
      end

      it "raises Viagogo::Error::ConfigurationError when :access_token is invalid" do
        expect { Viagogo::Client.new do |config|
          config.access_token = 50
        end }.to raise_error Viagogo::Error::ConfigurationError
      end

      it "raises Viagogo::Error::ConfigurationError when :access_token_secret is invalid" do
        expect { Viagogo::Client.new do |config|
          config.access_token_secret = 50
        end }.to raise_error Viagogo::Error::ConfigurationError
      end

      it "raises Viagogo::Error::ConfigurationError when :scope is invalid" do
        expect { Viagogo::Client.new do |config|
          config.scope = 50
        end }.to raise_error Viagogo::Error::ConfigurationError
      end
    end
  end

  describe "#user_agent" do
    it "returns the gem name and version" do
      version = Viagogo::VERSION
      expected_user_agent = "viagogo Ruby Gem #{version}"
      expect(@client.user_agent).to eq(expected_user_agent)
    end
  end

  describe "#credentials?" do
    it "returns false if :consumer_key is not supplied" do
      client = Viagogo::Client.new(:consumer_secret => "CS",
                                   :access_token => "AT",
                                   :access_token_secret => "AS")
      expect(client.credentials?).to be_false
    end

    it "returns false if :consumer_secret is not supplied" do
      client = Viagogo::Client.new(:consumer_key => "CK",
                                   :access_token => "AT",
                                   :access_token_secret => "AS")
      expect(client.credentials?).to be_false
    end

    it "returns false if :access_token is not supplied" do
      client = Viagogo::Client.new(:consumer_key => "CK",
                                   :consumer_secret => "CS",
                                   :access_token_secret => "AS")
      expect(client.credentials?).to be_false
    end

    it "returns false if :access_token_secret is not supplied" do
      client = Viagogo::Client.new(:consumer_key => "CK",
                                   :consumer_secret => "CS",
                                   :access_token => "AT")
      expect(client.credentials?).to be_false
    end

    it "returns true if all credentials are supplied" do
      client = Viagogo::Client.new(:consumer_key => "CK",
                                   :consumer_secret => "CS",
                                   :access_token => "AT",
                                   :access_token_secret => "AS")
      expect(client.credentials?).to be_true
    end
  end

  describe "#connection" do
    it "looks like a Faraday connection" do
      expect(@client.send(:connection)).to respond_to(:run_request)
    end

    it "caches the connection" do
      connection1, connection2 = @client.send(:connection), @client.send(:connection)
      expect(connection1.object_id).to eq(connection2.object_id)
    end
  end

  describe "#request" do
    it "makes an HTTP request with the parameters given" do
      expected_path = "/some/path"
      [:get, :post, :head, :put, :delete].each do |expected_method|
        stub_request(:any, Viagogo::Client::API_ENDPOINT + expected_path)
        @client.send(:request, expected_method, expected_path)
        expect(a_request(expected_method, Viagogo::Client::API_ENDPOINT + expected_path)).to have_been_made
      end
    end

    it "returns the response env Hash" do
      expected_response_hash = {:body => "abc"}
      stub_request(:any, Viagogo::Client::API_ENDPOINT + "/foo").to_return(expected_response_hash)
      actual_response_hash = @client.send(:request, :get, "/foo")
      expect(actual_response_hash[:body]).to eq(expected_response_hash[:body])
    end
  end

  describe "#get" do
    it "performs an get request" do
      expected_path = "/custom/path"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_get(expected_path).with(:query => expected_params)
      @client.get(expected_path, expected_params)
      expect(a_get(expected_path).with(:query => expected_params)).to have_been_made
    end
  end

  describe "#head" do
    it "performs an head request" do
      expected_path = "/custom/path"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_head(expected_path).with(:query => expected_params)
      @client.head(expected_path, expected_params)
      expect(a_head(expected_path).with(:query => expected_params)).to have_been_made
    end
  end

  describe "#delete" do
    it "performs an delete request" do
      expected_path = "/custom/path"
      expected_params = {:foo => "foo", :bar => "bar"}
      stub_delete(expected_path).with(:query => expected_params)
      @client.delete(expected_path, expected_params)
      expect(a_delete(expected_path).with(:query => expected_params)).to have_been_made
    end
  end

  describe "#post" do
    it "performs an post request" do
      expected_path = "/custom/path"
      expected_body = {:foo => "foo", :bar => "bar"}
      stub_post(expected_path).with(:body => expected_body)
      @client.post(expected_path, expected_body)
      expect(a_post(expected_path).with(:body => expected_body)).to have_been_made
    end
  end

  describe "#put" do
    it "performs an put request" do
      expected_path = "/custom/path"
      expected_body = {:foo => "foo", :bar => "bar"}
      stub_put(expected_path).with(:body => expected_body)
      @client.put(expected_path, expected_body)
      expect(a_put(expected_path).with(:body => expected_body)).to have_been_made
    end
  end
end
