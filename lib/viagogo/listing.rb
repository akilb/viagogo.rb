require 'ostruct'
require 'representable/json'
require 'viagogo/resource'

module Viagogo
  class Listing < OpenStruct
  end

  module ListingRepresenter
    include Representable::JSON

    property :id, as: :Id
    property :event_id, as: :EventId
    property :event_name, as: :EventName
    property :event, as: :Event, extend: Viagogo::ResourceRepresenter, class: Viagogo::Resource
    property :section, as: :Section
    property :row, as: :Row
    property :seat_from, as: :SeatFrom
    property :seat_to, as: :SeatTo
    property :available_tickets, as: :AvailableTickets
    property :default_current_price, as: :DefaultCurrentPrice
    property :currency_code, as: :CurrencyCode
    property :is_active, as: :IsActive
    property :ticket_class_description, as: :TicketClassDescription
    property :ticket_type, as: :TicketType
    property :splitting, as: :Splitting
  end
end
