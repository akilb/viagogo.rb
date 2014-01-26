require 'ostruct'
require 'representable/json'
require 'viagogo/site_url'
require 'viagogo/resource'

module Viagogo
  class Event < OpenStruct
  end

  module EventRepresenter
    include Representable::JSON

    property :id, as: :Id
    property :name, as: :Name
    property :start_datetime_utc, as: :StartDateTimeUtc #TODO Convert to DateTime
    property :end_datetime_utc, as: :EndDateTimeUtc #TODO Convert to DateTime
    property :start_datetime_local, as: :StartDateTimeLocal #TODO Convert to DateTime
    property :end_datetime_local, as: :EndDateTimeUtc #TODO Convert to DateTime
    property :total_listings, as: :TotalListings
    property :total_available_tickets, as: :TotalAvailableTickets
    property :minimum_price, as: :MinimumPrice
    property :maximum_price, as: :MaximumPrice
    property :default_currency_code, as: :DefaultCurrencyCode
    property :is_available_for_public_listing, as: :IsAvailableForPublicListing
    property :is_available_for_public_purchase, as: :IsAvailableForPublicPurchase
    property :has_premium_listings, as: :HasPremiumListings
    property :venue, as: :Venue, extend: Viagogo::ResourceRepresenter, class: Viagogo::Resource
    property :listings, as: :Listings, extend: Viagogo::ResourceRepresenter, class: Viagogo::Resource
    collection :site_urls, as: :SiteUrls, extend: Viagogo::SiteUrlRepresenter, class: Viagogo::SiteUrl
  end
end
