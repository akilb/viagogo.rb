require 'faraday_middleware'

module Viagogo
  module Response
    class FollowRedirects < FaradayMiddleware::FollowRedirects
      AUTH_HEADER = 'Authorization'.freeze

      private

      def update_env(env, request_body, response)
        env[:request_headers].delete(AUTH_HEADER)

        super(env, request_body, response)
      end
    end
  end
end
