require 'ostruct'
require 'representable/json'
require 'viagogo/resource'

module Viagogo
  class SiteUrl < OpenStruct
  end

  module SiteUrlRepresenter
    include Representable::JSON

    property :country_code, as: :CountryCode
    property :link, extend: Viagogo::ResourceRepresenter, class: Viagogo::Resource
  end
end
