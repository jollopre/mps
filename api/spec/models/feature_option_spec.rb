require 'rails_helper'

RSpec.describe FeatureOption do
  describe '#as_json' do
    let(:feature_option) do
      build(:bottom_gusset)
    end

    context 'when options are passed' do
      it 'returns a hash' do
        result = feature_option.as_json(only: :id)

        expect(result).to eq({ 'id' => nil })
      end
    end

    context 'when NO options are passed' do
      it 'includes only id and name' do
        result = feature_option.as_json

        expect(result).to eq({ 'id' => nil, 'name' => 'Bottom Gusset' })
      end
    end
  end
end
