require 'viagogo/listing'
require 'viagogo/page'
require 'viagogo/utils'

module Viagogo
  module Public
    module API
      module Listings
        include Viagogo::Utils

        def listing(id, params={})
          object_from_response(Viagogo::Listing,
                               Viagogo::ListingRepresenter,
                               :get,
                               "/Public/Listing/#{id}",
                               params)
        end

        def listings_by_event(event_id, params={})
          object_from_response(Viagogo::Page,
                               Viagogo::ListingPageRepresenter,
                               :get,
                               "/Public/Listing/ByEvent/#{event_id}",
                               params)
        end
      end
    end
  end
end
