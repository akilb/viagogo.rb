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

    private

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
