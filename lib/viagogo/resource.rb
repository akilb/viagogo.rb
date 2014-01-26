require 'ostruct'
require 'representable/json'
require 'viagogo/link'

module Viagogo
  class Resource < OpenStruct
  end

  module ResourceRepresenter
    include Representable::JSON

    property :link, as: :Link, extend: Viagogo::LinkRepresenter, class: Viagogo::Link
  end
end