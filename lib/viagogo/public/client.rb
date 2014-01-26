require 'viagogo/client'
require 'viagogo/public/api/countries'
require 'viagogo/public/api/geographies'
require 'viagogo/public/oauth'

module Viagogo
  module Public
    # Client for the viagogo API public service
    #
    # @see http://developer.viagogo.net/documentation/description-of-services/public-services
    class Client < Viagogo::Client
      include Viagogo::Public::API::Countries
      include Viagogo::Public::API::Geographies
      include Viagogo::Public::OAuth
    end
  end
end
