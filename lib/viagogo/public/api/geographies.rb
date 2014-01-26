require 'viagogo/geography'
require 'viagogo/page'
require 'viagogo/utils'

module Viagogo
  module Public
    module API
      module Geographies
        include Viagogo::Utils

        def geography(id, params={})
          object_from_response(Viagogo::Geography,
                               Viagogo::GeographyRepresenter,
                               :get,
                               "/Public/Geography/#{id}",
                               params)
        end

        def geographies(params={})
          object_from_response(Viagogo::Page,
                               Viagogo::GeographyPageRepresenter,
                               :get,
                               "/Public/Geography/All",
                               params)
        end
      end
    end
  end
end
