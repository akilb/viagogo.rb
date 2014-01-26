require 'ostruct'
require 'representable/json'
require 'viagogo/geography'

module Viagogo
  class Country < OpenStruct
  end

  module CountryRepresenter
    include Representable::JSON

    property :code, as: :Code
    property :name, as: :Name
    property :geography, as: :Geography, extend: GeographyRepresenter, class: Geography
  end
end
