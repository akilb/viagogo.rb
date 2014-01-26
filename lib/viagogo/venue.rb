require 'ostruct'
require 'representable/json'
require 'viagogo/resource'

module Viagogo
  class Venue < OpenStruct
  end

  module VenueRepresenter
    include Representable::JSON

    property :id, as: :Id
    property :name, as: :Name
    property :address_line_1, as: :AddressLine1
    property :address_line_2, as: :AddressLine2
    property :city, as: :City
    property :state_province, as: :StateProvince
    property :country_code, as: :CountryCode
    property :postal_code, as: :PostalCode
    property :metro_area, as: :MetroArea, extend: Viagogo::ResourceRepresenter, class: Viagogo::Resource
    property :events, as: :Events, extend: Viagogo::ResourceRepresenter, class: Viagogo::Resource
    property :time_zone_description, as: :TimeZoneDescription
  end
end