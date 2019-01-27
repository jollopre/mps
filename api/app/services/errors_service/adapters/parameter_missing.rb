require_relative './adapter'

class ErrorsService
  module Adapters
    class ParameterMissing
      include Adapter

      STATUS = 400.freeze
      attr_reader :errors

      def initialize(parameter_missing)
        @errors = [parameter_missing.message]
      end

      def status
        STATUS
      end
    end
  end
end
