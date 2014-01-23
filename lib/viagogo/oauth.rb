require 'cgi'
require 'viagogo/token'

module Viagogo
  # OAuth authentication helper methods for [Viagogo::Client]
  module OAuth
    def public_access_token
      response = get("/Public/SimpleOAuthAccessRequest",
                     {:scope => scope, :is_token_request => true, :raw => true})

      utcNowTime = Time.now.utc
      tokenAndSecret = CGI.parse(response[:body] || "")
      Token.new do |token|
        token.expiry_timestamp = utcNowTime + (24 * 60 * 60)
        token.issue_timestamp = utcNowTime
        token.oauth_token = tokenAndSecret["oauth_token"][0]
        token.oauth_token_secret = tokenAndSecret["oauth_token_secret"][0]
        token.scope = scope
        token.type = "access token"
      end
    end

  end
end
