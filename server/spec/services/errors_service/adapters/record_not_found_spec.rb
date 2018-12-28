require 'rails_helper'
require './app/services/errors_service/adapters/record_not_found'

RSpec.describe ErrorsService::Adapters::RecordNotFound do
  let(:record_not_found) do
    ActiveRecord::RecordNotFound.new('Record not found')
  end

  describe '#errors' do
    it 'returns the errors messages within an array' do
      adapter = described_class.new(record_not_found)

      expect(adapter.errors).to eq(['Record not found'])
    end
  end

  describe '#status' do
    it 'returns the status associated to these errors' do
      adapter = described_class.new(record_not_found)

      expect(adapter.status).to eq(404)
    end
  end
end

