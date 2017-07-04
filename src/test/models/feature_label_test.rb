require 'test_helper'

class FeatureLabelTest < ActiveSupport::TestCase
	setup do
		@feature_label = feature_labels(:label1)
	end
	test 'as_json returns every attribute specified at serializable_hash' do
		feature_label_hash = @feature_label.as_json()
		keys = feature_label_hash.keys()
		assert_includes(keys, 'name')
	end
end
