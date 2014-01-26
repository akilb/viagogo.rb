require 'viagogo/metro_area'
require 'viagogo/page'
require 'viagogo/utils'

module Viagogo
  module Public
    module API
      module MetroAreas
        include Viagogo::Utils

        def metro_area(id, params={})
          object_from_response(Viagogo::MetroArea,
                               Viagogo::MetroAreaRepresenter,
                               :get,
                               "/Public/MetroArea/#{id}",
                               params)
        end

        def metro_areas(params={})
          object_from_response(Viagogo::Page,
                               Viagogo::MetroAreaPageRepresenter,
                               :get,
                               "/Public/MetroArea/All",
                               params)
        end
      end
    end
  end
end
