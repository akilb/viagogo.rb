require 'faraday'
require 'faraday_middleware'
require 'viagogo/response/follow_redirects'
require 'viagogo/response/raise_error'
require 'viagogo/response/underscorify_hash'

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

    def connection(endpoint, is_token_request=false)
      Faraday::Connection.new(endpoint, connection_options) do |builder|
        request_credentials = credentials.clone.delete_if do |k,v|
          k == :token || k == :token_secret if is_token_request
        end
        # Signs requests according to the OAuth protocol
        builder.use FaradayMiddleware::OAuth, request_credentials
        # Encodes request the body as JSON
        builder.use FaradayMiddleware::EncodeJson
        # Automatically follow 301, 302 and 307 redirects
        builder.use Viagogo::Response::FollowRedirects
        # Handle error responses
        builder.use Viagogo::Response::RaiseError
        # Convert CamelCase JSON keys to under_score
        builder.use Viagogo::Response::UnderscorifyHash unless is_token_request
        # Parse response JSON
        builder.use FaradayMiddleware::ParseJson unless is_token_request

        # Set Faraday's HTTP adapter
        builder.adapter Faraday.default_adapter
      end
    end
  end
end