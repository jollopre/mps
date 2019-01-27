require 'rails_helper'

RSpec.describe Feature do
  let(:bag_style) do
    option = build(:bottom_gusset, id: 1)
    build(:bag_style, feature_options: [option])
  end

  describe '.enum' do
    context 'when feature_type is not one of the defined types' do
      it 'raises ArgumentError' do
        expect do
          build(:feature, feature_type: 'wadus')
        end.to raise_error(ArgumentError, /'wadus' is not a valid feature_type/)
      end
    end
  end

  describe '#feature_option_id?' do
    context 'when feature_option exists for the feature' do
      it 'returns true' do
        result = bag_style.feature_option_id?(1)

        expect(result).to be(true)
      end
    end

    context 'when feature_option does NOT exist for the feature' do
      it 'returns false' do
        result = bag_style.feature_option_id?(2)

        expect(result).to be(false)
      end
    end
  end

  describe '#find_feature_option_by_id' do
    context 'when feature_option exists for the feature' do
      it 'returns it' do
        result = bag_style.find_feature_option_by_id(1)

        expect(result.id).to eq(1)
      end
    end

    context 'when feature_option does NOT exist for the feature' do
      it 'returns nil' do
        result = bag_style.find_feature_option_by_id(2)

        expect(result).to be_nil
      end
    end
  end

  describe '#as_json' do
    let(:bag_style) do
      option = build(:bottom_gusset, id: 1)
      build(:bag_style, feature_options: [option])
    end

    context 'when options are passed' do
      it 'returns a hash' do
        result = bag_style.as_json(only: :feature_type)

        expect(result).to eq({ 'feature_type' => 'option' })
      end
    end

    context 'when NO options are passed' do
      it 'id and feature_type are returned' do
        result = bag_style.as_json

        expect(result).to include('id', 'feature_type', 'feature_label')
      end

      it 'include a hash for feature_options' do
        result = bag_style.as_json

        expect(result).to include('feature_options' => { 1 => { 'id' => 1, 'name' => 'Bottom Gusset' }})
      end
    end
  end
end
