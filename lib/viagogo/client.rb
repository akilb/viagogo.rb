require 'faraday'
require 'viagogo/error/configuration_error'
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

    API_ENDPOINT = "https://api.viagogo.net".freeze

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

    private

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @client ||= Faraday.new(:url => API_ENDPOINT)
    end


    # Perform an HTTP request
    #
    # @return [Hash] object containing response information
    def request(method, path, params = {}, signature_params = params)
      response = connection.send(method.to_sym, path, params)
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
