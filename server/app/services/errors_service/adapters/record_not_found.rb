require_relative './adapter'

class ErrorsService
  module Adapters
    class RecordNotFound
      include Adapter

      STATUS = 404.freeze
      attr_reader :errors

      def initialize(record_not_found)
        @errors = [record_not_found.message]
      end

      def status
        STATUS
      end
    end
  end
end
