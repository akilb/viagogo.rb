module Viagogo
  # Custom error class for rescuing from all viagogo errors
  class Error < StandardError; end

  class ConfigurationError < Error; end

  # Raised when viagogo returns the HTTP status code 400
  class BadRequestError < Error; end

  # Raised when viagogo returns the HTTP status code 401
  class UnauthorizedError < Error; end

  # Raised when viagogo returns the HTTP status code 403
  class ForbiddenError < Error; end

  # Raised when viagogo returns the HTTP status code 404
  class NotFoundError < Error; end

  # Raised when viagogo returns the HTTP status code 405
  class MethodNotAllowedError < Error; end

  # Raised when viagogo returns the HTTP status code 500
  class InternalServerError < Error; end

end
