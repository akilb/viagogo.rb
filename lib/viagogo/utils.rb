module Viagogo
  module Utils
    def object_from_response(klass,
                             klass_representer,
                             request_method,
                             path,
                             options = {})
      response = send(request_method.to_sym, path, options)
      klass.new.extend(klass_representer).from_json(response[:body])
    end
  end
end
