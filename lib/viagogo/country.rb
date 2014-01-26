require 'ostruct'
require 'representable/json'
require 'viagogo/resource'

module Viagogo
  class Country < OpenStruct
  end

  module CountryRepresenter
    include Representable::JSON

    property :code, as: :Code
    property :name, as: :Name
    property :geography, as: :Geography, extend: Viagogo::ResourceRepresenter, class: Viagogo::Resource
  end
end
