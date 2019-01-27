require 'rails_helper'
require './app/services/errors_service/adapters/record_invalid'

RSpec.describe ErrorsService::Adapters::RecordInvalid do
  RecordClass = Class.new do
    extend ActiveModel::Naming
    extend ActiveModel::Translation

    attr_reader :errors
    attr_accessor :attribute1

    def initialize
      @errors = ActiveModel::Errors.new(self)
    end

    def read_attribute_for_validation(attr)
      send(attr)
    end
  end

  let(:record_invalid) do
    record = RecordClass.new
    record.errors.add(:attribute1, :presence, message: 'must be present')
    ActiveRecord::RecordInvalid.new(record)
  end

  describe '#errors' do
    it 'returns the errors messages within an array' do
      adapter = described_class.new(record_invalid)

      expect(adapter.errors).to eq(['Attribute1 must be present'])
    end
  end

  describe '#status' do
    it 'returns the status associated to these errors' do
      adapter = described_class.new(record_invalid)

      expect(adapter.status).to eq(422)
    end
  end
end

