require_relative './adapter'

class ErrorsService
  module Adapters
    class RecordInvalid
      include Adapter

      STATUS = 422.freeze
      attr_reader :errors

      def initialize(record_invalid)
        @errors = record_invalid.record.errors.full_messages
      end

      def status
        STATUS
      end
    end
  end
end
