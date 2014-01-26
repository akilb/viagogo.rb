require 'ostruct'
require 'representable/json'

module Viagogo
  class Link < OpenStruct
  end

  module LinkRepresenter
    include Representable::JSON

    property :href, as: :HRef
    property :type, as: :Type
    property :rel, as: :Rel
    property :target, as: :Target
  end
end
