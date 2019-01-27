require 'rails_helper'

RSpec.describe FeatureLabel do
  describe '#serializable_hash' do
    let(:feature_label) do
      build(:width_label)
    end

    context 'when options are passed' do
      it 'returns a hash' do
        result = feature_label.as_json(only: :id)

        expect(result).to eq({ 'id' => nil })
      end
    end

    context 'when NO options are passed' do
      it 'includes only name' do
        result = feature_label.as_json

        expect(result).to eq({ 'name' => 'Width' })
      end
    end
  end
end
