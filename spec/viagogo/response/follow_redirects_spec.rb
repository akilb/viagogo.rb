require 'spec_helper'

describe Viagogo::Response::FollowRedirects do
  def connection
    Faraday.new do |c|
      c.use described_class, {}

      c.adapter :test do |stub|
        yield(stub) if block_given?
      end
    end
  end

  describe "#call" do
    it "redirects without original authorization headers" do
      conn = connection do |stub|
        stub.get('/redirect') {[301, {'Location' => '/found'}, '']}
        stub.get('/found') { |env|
          [200, {'Content-Type' => 'text/plain'}, env[:request_headers]['Authorization']]
        }
      end

      response = conn.get('/redirect') { |req|
        req.headers['Authorization'] = 'failed'
      }

      expect(response.body).to be_nil
    end
  end
end
