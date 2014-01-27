require 'ostruct'
require 'representable/json'
require 'viagogo/resource'
require 'viagogo/site_url'

module Viagogo
  class Category < OpenStruct
  end

  module CategoryRepresenter
    include Representable::JSON

    property :id, as: :Id
    property :name, as: :Name
    property :image_url, as: :ImageUrl
    property :events, as: :Events, extend: Viagogo::ResourceRepresenter, class: Viagogo::Resource
    collection :child_categories, as: :ChildCategories, extend: Viagogo::ResourceRepresenter, class: Viagogo::Resource
    collection :parent_categories, as: :ParentCategories, extend: Viagogo::ResourceRepresenter, class: Viagogo::Resource
    collection :site_urls, as: :SiteUrls, extend: Viagogo::SiteUrlRepresenter, class: Viagogo::SiteUrl
  end
end
