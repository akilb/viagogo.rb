require 'cgi'
require 'viagogo/token'

module Viagogo
  module Public
    # OAuth authentication helper methods for [Viagogo::Public::Client]
    module OAuth
      def get_access_token(scope="API.Public")
        response = get("/Public/SimpleOAuthAccessRequest",
                       {:scope => scope, :is_token_request => true})

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
end
