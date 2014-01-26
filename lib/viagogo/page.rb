require 'ostruct'
require 'representable/json'
require 'viagogo/country'
require 'viagogo/geography'

module Viagogo
  class Page < OpenStruct
  end

  module PageRepresenter
    include Representable::JSON

    property :maximum_timestamp, as: :MaximumTimeStamp
    property :total_result_count, as: :TotalResultCount
    property :total_number_of_page, as: :TotalNumberOfPages
    property :current_page, as: :Currentpage
    property :page_size, as: :PageSize
    #TODO DeletedItems
  end

  module CountryPageRepresenter
    include Representable::JSON
    include Viagogo::PageRepresenter

    collection :results, as: :Results, extend: Viagogo::CountryRepresenter, class: Viagogo::Country
  end

  module GeographyPageRepresenter
    include Representable::JSON
    include Viagogo::PageRepresenter

    collection :results, as: :Results, extend: Viagogo::GeographyRepresenter, class: Viagogo::Geography
  end
end
