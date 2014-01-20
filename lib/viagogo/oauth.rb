module Viagogo
  # OAuth authentication helper methods for [Viagogo::Client]
  module OAuth
    def public_access_token
      get("/Public/SimpleOAuthAccessRequest", {:scope => scope, :is_token_request => true})
    end
  end
end
