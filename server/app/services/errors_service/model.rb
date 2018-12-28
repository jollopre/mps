class ErrorsService
  class Model
    DEFAULT_STATUS = 400.freeze
    DEFAULT_DETAIL = ''.freeze

    attr_accessor :status, :detail

    def initialize(args = {})
      @status = args.fetch(:status, DEFAULT_STATUS)
      @detail = args.fetch(:detail, DEFAULT_DETAIL)
    end

    def to_h
      { status: status, detail: detail }
    end
  end
end
