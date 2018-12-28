require_relative '../errors_adapter'

class ErrorsService
  module ErrorsAdapter
    class RecordInvalid
      STATUS = 400.freeze
      include ErrorsAdapter
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
