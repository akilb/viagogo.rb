require 'ostruct'
require 'representable/json'
require 'viagogo/resource'

module Viagogo
  class Geography < OpenStruct
  end

  module GeographyRepresenter
    include Representable::JSON

    property :id, as: :Id
    property :name, as: :Name
    property :country, as: :Country, extend: Viagogo::ResourceRepresenter, class: Viagogo::Resource
  end
end
