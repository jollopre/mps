require_relative './errors_service/model'

class ErrorsService
  class << self
    def do(errorable_exception)
      errors = errorable_exception.errors.reduce([]) do |acc, message|
        acc << Model.new(status: errorable_exception.status, detail: message).to_h
      end
      { errors: errors }
    end
  end
end
