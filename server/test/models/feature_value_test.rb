require 'test_helper'

class FeatureValueTest < ActiveSupport::TestCase
  setup do
    @fv_float = feature_values(:fv_float)
    @fv_integer = feature_values(:fv_integer)
    @fv_option = feature_values(:fv_option)
    @fv_option.value = feature_options(:feature_option1).id
    @fv_string = feature_values(:fv_string)
  end

  test 'as_json returns every attribute specified at serializable_hash' do
    fv_hash = @fv_float.as_json()
    keys = fv_hash.keys()
    assert_includes(keys, 'id')
    assert_includes(keys, 'feature_id')
    assert_includes(keys, 'enquiry_id')
    assert_includes(keys, 'value')
  end
  test 'value_to_feature_type conform to its feature_type' do
    assert(@fv_float.value_to_feature_type().is_a?(Float))
    assert(@fv_integer.value_to_feature_type().is_a?(Integer))
    assert(@fv_option.value_to_feature_type().is_a?(Integer))
    assert(@fv_string.value_to_feature_type().is_a?(String))
  end
  test 'value_to_feature_type returns nil for empty string values' do
    @fv_float.value = ''
    @fv_integer.value = ''
    @fv_option.value = ''
    @fv_string.value = ''
    assert_nil(@fv_float.value_to_feature_type())
    assert_nil(@fv_integer.value_to_feature_type())
    assert_nil(@fv_option.value_to_feature_type())
    assert_nil(@fv_string.value_to_feature_type())
  end
  test 'save raises ActiveRecord::RecordInvalid exception for a non-float value' do
    @fv_float.value = 'whatever'
    assert_raises ActiveRecord::RecordInvalid do
      @fv_float.save!
    end
  end
  test 'save raises ActiveRecord::RecordInvalid exception for a non-integer value' do
    @fv_integer.value = 'whatever'
    assert_raises ActiveRecord::RecordInvalid do
      @fv_integer.save!
    end
  end
  test 'save raises ActiveRecord::RecordInvalid exception for a non-existent option_id' do
    @fv_option.value = 'whatever'
    err = assert_raises ActiveRecord::RecordInvalid do
      @fv_option.save!
    end
    assert_match(/Validation failed: Value invalid value for Integer\(\): "whatever"/, err.message)
    @fv_option.value = 100000
    err = assert_raises ActiveRecord::RecordInvalid do
      @fv_option.save!
    end
    assert_match(/Validation failed: Value It does not exist a FeatureOption with id 100000/, err.message)
  end
end
