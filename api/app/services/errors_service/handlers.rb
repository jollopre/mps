class ErrorsService
  module Handlers
    def parameter_missing(exception)
      errors = ErrorsService.do(ErrorsService::Adapters::ParameterMissing.new(exception))
      render json: errors, status: :bad_request
    end

    def record_invalid(exception)
      errors = ErrorsService.do(ErrorsService::Adapters::RecordInvalid.new(exception))
      render json: errors, status: :unprocessable_entity
    end

    def record_not_found(exception)
      errors = ErrorsService.do(ErrorsService::Adapters::RecordNotFound.new(exception))
      render json: errors, status: :not_found
    end

    class << self
      def included(rescuable_module)
        rescuable_module.rescue_from ActionController::ParameterMissing, with: :parameter_missing
        rescuable_module.rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
        rescuable_module.rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      end
    end
  end
end
