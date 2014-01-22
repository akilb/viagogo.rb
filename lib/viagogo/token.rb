module Viagogo
  class Token
    attr_accessor :expiry_timestamp,
                  :issue_timestamp,
                  :oauth_token,
                  :oauth_token_secret,
                  :scope,
                  :type

    def initialize(options={})
      options.each do |key, value|
        send(:"#{key}=", value)
      end
      yield self if block_given?
    end
  end
end
