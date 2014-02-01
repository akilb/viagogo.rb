module Viagogo
  module Utils
    def object_from_response(klass,
                             klass_representer,
                             request_method,
                             path,
                             options = {})
      response = send(request_method.to_sym, path, options)
      response[:status] == 200 ? klass.new.extend(klass_representer).from_json(response[:body] || "") : nil
    end

    # Converts a Microsoft JSON date string to a [DateTime]
    #
    # @see http://stackoverflow.com/a/726869/656694
    def self.parse_microsoft_json_date(date_string)
      return nil if date_string.nil?

      milliseconds_and_timezone = date_string.delete("/").
                                              delete("Date(").
                                              delete(")").
                                              split(/[+-]/)
      date_time = DateTime.strptime(milliseconds_and_timezone[0],'%Q')
      offset_sign = date_string.index('-').nil? ? '+' : '-'
      offset = offset_sign + (milliseconds_and_timezone[1] || "0000")
      date_time_with_offset = DateTime.new(date_time.year,
                                           date_time.month,
                                           date_time.day,
                                           date_time.hour,
                                           date_time.minute,
                                           date_time.second,
                                           offset)
    end
  end
end
