require 'rails_helper'

RSpec.describe FeatureValue do
  let(:width) do
    feature = build(:width)
    build(:feature_value, feature: feature, value: 34.5) 
  end
  let(:no_printed_sides) do
    feature = build(:no_printed_sides)
    build(:feature_value, feature: feature, value: 2)
  end
  let(:bag_style) do
    feature = build(:bag_style)
    build(:feature_value, feature: feature, value: 1)
  end
  let(:handle_colour) do
    feature = build(:handle_colour)
    enquiry = build(:enquiry)
    build(:feature_value, feature: feature, value: 'yellow', enquiry: enquiry)
  end
  describe '#as_json' do
    context 'when options are passed' do
      it 'returns a hash' do
        result = width.as_json(only: :value)

        expect(result).to eq({ 'value' => '34.5' })
      end
    end

    context 'when NO options are passed' do
      it 'includes id, feature_id and enquiry_id' do
        result = width.as_json

        expect(result).to include('id', 'feature_id', 'enquiry_id')
      end

      context 'when the feature_type is float' do
        it 'returns value coerced to float' do
          result = width.as_json

          expect(result).to include({ 'value' => 34.5 })
        end
      end

      context 'when the feature_type is integer' do
        it 'returns value coerced to integer' do
          result = no_printed_sides.as_json 

          expect(result).to include({ 'value' => 2 })
        end
      end

      context 'when the feature_type is option' do
        it 'returns value coerced to integer' do
          result = bag_style.as_json

          expect(result).to include({ 'value' => 1 })
        end
      end

      context 'when the feature_type is string' do
        it 'returns value as stored' do
          result = handle_colour.as_json 

          expect(result).to include({ 'value' => 'yellow' })
        end
      end
    end
  end

  describe '.validate' do
    describe '#must_be_valid_type_for_value' do
      context 'when value for float feature is not valid' do
        it 'raises ActiveRecord::RecordInvalid' do
          width.value = 'wadus'

          expect do
            width.validate!
          end.to raise_error(ActiveRecord::RecordInvalid, /Value invalid value for float feature/)
        end
      end

      context 'when value for integer feature is not valid' do
        it 'raises ActiveRecord::RecordInvalid' do
          no_printed_sides.value = 'wadus'

          expect do
            no_printed_sides.validate!
          end.to raise_error(ActiveRecord::RecordInvalid, /Value invalid value for integer feature/)
        end
      end

      context 'when value for option feature is not valid' do
        context 'when type is not valid' do
          it 'raises ActiveRecord::RecordInvalid' do
            bag_style.value = 'wadus' 

            expect do
              bag_style.validate!
            end.to raise_error(ActiveRecord::RecordInvalid, /Value invalid value for option feature/)
          end
        end

        context 'when option id does not exist for feature' do
          it 'raises ActiveRecord::RecordInvalid' do
            bag_style.value = 1

            expect do
              bag_style.validate!
            end.to raise_error(ActiveRecord::RecordInvalid, /Value is not included in the feature_option_ids for feature/)
          end
        end
      end

      context 'when value for feature is valid' do
        it 'does not raise any error' do
          handle_colour.value = 'yellow'

          expect do
            handle_colour.validate!
          end.not_to raise_error
        end
      end
    end
  end
end
