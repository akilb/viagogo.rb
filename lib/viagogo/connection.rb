require 'faraday'
require 'faraday_middleware'
require 'viagogo/response/follow_redirects'
require 'viagogo/response/raise_error'

module Viagogo
  module Connection
    private

    def connection_options
      @connection_options ||= {
        :headers => {
            :accept => 'application/json',
            :content_type => 'application/json',
            :user_agent => user_agent,
        },
        :request => {
            :open_timeout => 5,
            :timeout => 10
        },
      }
    end

    def connection(endpoint, raw=false)
      Faraday::Connection.new(endpoint, connection_options) do |builder|
        # Signs requests according to the OAuth protocol
        builder.use FaradayMiddleware::OAuth, credentials
        # Encodes request the body as JSON
        builder.use FaradayMiddleware::EncodeJson
        # Automatically follow 301, 302 and 307 redirects
        builder.use Viagogo::Response::FollowRedirects
        # Handle error responses
        builder.use Viagogo::Response::RaiseError
        # Parse response JSON
        builder.use FaradayMiddleware::ParseJson unless raw

        # Set Faraday's HTTP adapter
        builder.adapter Faraday.default_adapter
      end
    end
  end
end