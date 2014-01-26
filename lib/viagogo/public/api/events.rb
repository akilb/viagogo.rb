require 'viagogo/event'
require 'viagogo/page'
require 'viagogo/utils'

module Viagogo
  module Public
    module API
      module Events
        include Viagogo::Utils

        def event(id, params={})
          object_from_response(Viagogo::Event,
                               Viagogo::EventRepresenter,
                               :get,
                               "/Public/Event/#{id}",
                               params)
        end

        def events_by_category(category_id, params={})
          object_from_response(Viagogo::Page,
                               Viagogo::EventPageRepresenter,
                               :get,
                               "/Public/Event/ByCategory/#{category_id}",
                               params)
        end

        def events_by_metro_area(metro_area_id, params={})
          object_from_response(Viagogo::Page,
                               Viagogo::EventPageRepresenter,
                               :get,
                               "/Public/Event/ByMetroArea/#{metro_area_id}",
                               params)
        end

        def events_by_venue(venue_id, params={})
          object_from_response(Viagogo::Page,
                               Viagogo::EventPageRepresenter,
                               :get,
                               "/Public/Event/ByVenue/#{venue_id}",
                               params)
        end

        def events_by_utc_start_date(year, month, day, params={})
          object_from_response(Viagogo::Page,
                               Viagogo::EventPageRepresenter,
                               :get,
                               "/Public/Event/ByUtcStartDate/#{year}/#{month}/#{day}",
                               params)
        end

        def events_search(query, params={})
          object_from_response(Viagogo::Page,
                               Viagogo::EventPageRepresenter,
                               :get,
                               "/Public/Event/Search",
                               params.merge(:searchText => query))
        end
      end
    end
  end
end
