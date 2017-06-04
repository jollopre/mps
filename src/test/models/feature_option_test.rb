require 'test_helper'

class FeatureOptionTest < ActiveSupport::TestCase
	setup do
		@feature_option = feature_options(:feature_option1)
	end
	test 'as_json returns every attribute specified at serializable_hash' do
		feature_option_hash = @feature_option.as_json()
		keys = feature_option_hash.keys()
		assert_includes(keys, 'id')
		assert_includes(keys, 'name')
	end
end
