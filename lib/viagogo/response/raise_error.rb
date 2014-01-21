require 'faraday'
require 'viagogo/error'

module Viagogo
  module Response
    class RaiseError < Faraday::Middleware
      def initialize(app, options = {})
        super(app)
        @options = options
      end

      def call(env)
        @app.call(env).on_complete do |response|
          case response[:status].to_i
            when 400
              raise Viagogo::BadRequestError, error_message_400(response)
            when 401
              raise Viagogo::UnauthorizedError, error_message_400(response)
            when 403
              raise Viagogo::ForbiddenError, error_message_400(response)
            when 404
              raise Viagogo::NotFoundError, error_message_400(response)
            when 405
              raise Viagogo::MethodNotAllowedError, error_message_400(response)
            when 500
              raise Viagogo::InternalServerError
          end
        end
      end

      def error_message_400(response)
        "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}}"
      end
    end
  end
end
