require 'ostruct'
require 'representable/json'
require 'viagogo/resource'

module Viagogo
  class MetroArea < OpenStruct
  end

  module MetroAreaRepresenter
    include Representable::JSON

    property :id, as: :Id
    property :name, as: :Name
    property :geography, as: :Geography, extend: Viagogo::ResourceRepresenter, class: Viagogo::Resource
    property :venues, as: :Venues, extend: Viagogo::ResourceRepresenter, class: Viagogo::Resource
  end
end
