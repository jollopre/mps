require 'rails_helper'
require './app/services/errors_service/adapters/parameter_missing'

RSpec.describe ErrorsService::Adapters::ParameterMissing do
  let(:parameter_missing) do
    ActionController::ParameterMissing.new('param1')
  end

  describe '#errors' do
    it 'returns the errors messages within an array' do
      adapter = described_class.new(parameter_missing)

      expect(adapter.errors).to eq(['param is missing or the value is empty: param1'])
    end
  end

  describe '#status' do
    it 'returns the status associated to these errors' do
      adapter = described_class.new(parameter_missing)

      expect(adapter.status).to eq(400)
    end
  end
end

