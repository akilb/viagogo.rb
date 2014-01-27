require 'ostruct'
require 'representable/json'
require 'viagogo/category'
require 'viagogo/country'
require 'viagogo/event'
require 'viagogo/geography'
require 'viagogo/listing'
require 'viagogo/metro_area'
require 'viagogo/venue'

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

  module CategoryPageRepresenter
    include Representable::JSON
    include Viagogo::PageRepresenter

    collection :results, as: :Results, extend: Viagogo::CategoryRepresenter, class: Viagogo::Category
  end

  module CountryPageRepresenter
    include Representable::JSON
    include Viagogo::PageRepresenter

    collection :results, as: :Results, extend: Viagogo::CountryRepresenter, class: Viagogo::Country
  end

  module EventPageRepresenter
    include Representable::JSON
    include Viagogo::PageRepresenter

    collection :results, as: :Results, extend: Viagogo::EventRepresenter, class: Viagogo::Event
  end

  module GeographyPageRepresenter
    include Representable::JSON
    include Viagogo::PageRepresenter

    collection :results, as: :Results, extend: Viagogo::GeographyRepresenter, class: Viagogo::Geography
  end

  module ListingPageRepresenter
    include Representable::JSON
    include Viagogo::PageRepresenter

    collection :results, as: :Results, extend: Viagogo::ListingRepresenter, class: Viagogo::Listing
  end

  module MetroAreaPageRepresenter
    include Representable::JSON
    include Viagogo::PageRepresenter

    collection :results, as: :Results, extend: Viagogo::MetroAreaRepresenter, class: Viagogo::MetroArea
  end

  module VenuePageRepresenter
    include Representable::JSON
    include Viagogo::PageRepresenter

    collection :results, as: :Results, extend: Viagogo::VenueRepresenter, class: Viagogo::Venue
  end
end
