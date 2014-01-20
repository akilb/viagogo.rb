require 'faraday'
require 'faraday_middleware'
require 'viagogo/error/configuration_error'
require 'viagogo/oauth'
require 'viagogo/version'

module Viagogo

  # Client for the viagogo API
  #
  # @see http://developer.viagogo.net
  class Client
    attr_accessor :access_token,
                  :access_token_secret,
                  :consumer_key,
                  :consumer_secret,
                  :scope
    include Viagogo::OAuth

    # TODO: Use SSL
    API_ENDPOINT = "http://api.viagogo.net".freeze

    # Initializes a new Client
    #
    # @param options [Hash]
    # @raise [Viagogo::Error::ConfigurationError] Error is raised when supplied
    #   viagogo credentials are not a String or Symbol.
    # @return [Viagogo::Client]
    def initialize(options={})
      options.each do |key, value|
        send(:"#{key}=", value)
      end
      yield self if block_given?

      @scope ||= "API.Public"

      validate_credential_type!
    end

    # @return [Hash]
    def credentials
      {
          :consumer_key    => consumer_key,
          :consumer_secret => consumer_secret,
          :token           => access_token,
          :token_secret    => access_token_secret,
      }
    end

    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end

    # @return [String]
    def user_agent
      @user_agent ||= "viagogo Ruby Gem #{Viagogo::VERSION}"
    end

    # Perform an HTTP HEAD request
    def delete(path, params = {})
      request(:delete, path, params)
    end

    # Perform an HTTP GET request
    def get(path, params = {})
      request(:get, path, params)
    end

    # Perform an HTTP HEAD request
    def head(path, params = {})
      request(:head, path, params)
    end

    # Perform an HTTP POST request
    def post(path, params = {})
      request(:post, path, params)
    end

    # Perform an HTTP PUT request
    def put(path, params = {})
      request(:put, path, params)
    end

    # @note Faraday's middleware stack implementation is comparable to that of
    # Rack middleware.  The order of middleware is important: the first middleware
    # on the list wraps all others, while the last middleware is the innermost one.
    # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
    # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
    # @return [Faraday::Builder]
    def middleware
      @middleware ||= Faraday::Builder.new do |builder|
        # TODO include OAuth middleware
        # Signs requests according to the OAuth protocol
        #builder.use FaradayMiddleware::OAuth

        # Convert request params to "www-form-urlencoded"
        builder.use Faraday::Request::UrlEncoded
        # Automatically follow 301, 302 and 307 redirects
        builder.use FaradayMiddleware::FollowRedirects

        # Set Faraday's HTTP adapter
        builder.adapter Faraday.default_adapter
      end
    end

    private

    def connection_options
      @connection_options ||= {
          :builder => middleware,
          :headers => {
              :accept => 'application/json',
              :user_agent => user_agent,
          },
          :request => {
              :open_timeout => 5,
              :timeout => 10,
          },
      }
    end

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @client ||= Faraday.new(API_ENDPOINT, connection_options)
    end

    # Perform an HTTP request
    #
    # @return [Hash] object containing response information
    def request(method, path, params = {}, signature_params = params)
      is_token_request = params.delete(:is_token_request)

      response = connection.send(method.to_sym, path, params) do |request|
        if !is_token_request and (access_token.nil? or access_token_secret.nil?)
          public_access_token
        end

        if is_token_request
          request[:accept] = '*/*'
        end
      end
      response.env
    end

    # Ensures that all credentials set during configuration are of a
    # valid type. Valid types are String and Symbol.
    #
    # @raise [Viagogo::Error::ConfigurationError] Error is raised when
    #   supplied viagogo credentials are not a String or Symbol.
    def validate_credential_type!
      credentials.merge({ :scope => scope }).each do |credential, value|
        next if value.nil? || value.is_a?(String) || value.is_a?(Symbol)
        fail(Error::ConfigurationError,
             "Invalid #{credential} specified: #{value.inspect} must be a string or symbol.")
      end
    end
  end
end
