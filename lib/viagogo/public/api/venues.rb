require 'viagogo/page'
require 'viagogo/utils'
require 'viagogo/venue'

module Viagogo
  module Public
    module API
      module Venues
        include Viagogo::Utils

        def venue(id, params={})
          object_from_response(Viagogo::Venue,
                               Viagogo::VenueRepresenter,
                               :get,
                               "/Public/Venue/#{id}",
                               params)
        end

        def venues_by_metro_area(metro_area_id, params={})
          object_from_response(Viagogo::Page,
                               Viagogo::VenuePageRepresenter,
                               :get,
                               "/Public/Venue/ByMetroArea/#{metro_area_id}",
                               params)
        end
      end
    end
  end
end
