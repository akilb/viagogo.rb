require 'viagogo/category'
require 'viagogo/page'
require 'viagogo/utils'

module Viagogo
  module Public
    module API
      module Categories
        include Viagogo::Utils

        def category(id, params={})
          object_from_response(Viagogo::Category,
                               Viagogo::CategoryRepresenter,
                               :get,
                               "/Public/Category/#{id}",
                               params)
        end

        def categories_top(country_code, params={})
          object_from_response(Viagogo::Page,
                               Viagogo::CategoryPageRepresenter,
                               :get,
                               "/Public/Category/#{country_code}/Top",
                               params)
        end

        def categories_parents(country_code, id, params={})
          object_from_response(Viagogo::Page,
                               Viagogo::CategoryPageRepresenter,
                               :get,
                               "/Public/Category/#{country_code}/Parents/#{id}",
                               params)
        end

        def categories_children(country_code, id, params={})
          object_from_response(Viagogo::Page,
                               Viagogo::CategoryPageRepresenter,
                               :get,
                               "/Public/Category/#{country_code}/Children/#{id}",
                               params)
        end
      end
    end
  end
end
