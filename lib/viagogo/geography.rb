require 'ostruct'
require 'representable/json'
require 'viagogo/link'

module Viagogo
  class Geography < OpenStruct
  end

  module GeographyRepresenter
    include Representable::JSON

    property :link, as: :Link, extend: LinkRepresenter, class: Link
  end
end
