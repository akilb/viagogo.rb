require 'faraday'

module Viagogo
  module Response
    class UnderscorifyHash < Faraday::Response::Middleware
      def parse(body)
        underscorify_value(body)
      end

      def underscorify_value(value)
        case value
          when Hash
            Hash[value.map do |k, v|
              [underscorify_key(k), underscorify_value(v)]
            end]
          when Array
            value.map do |el|
              underscorify_value(el)
            end
          else
            value
        end
      end

      def underscorify_key(key)
        case key
          when String
            key.gsub(/::/, '/').
                gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
                gsub(/([a-z\d])([A-Z])/,'\1_\2').
                tr("-", "_").
                downcase
          else
            key
        end
      end
    end
  end
end