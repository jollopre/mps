require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  	setup do
		@f = features(:feature3)
		@fo1 = feature_options(:feature_option1)
		@fo2 = feature_options(:feature_option2)
	end

	test 'creates raises ArgumentError exception for a non-valid feature_type' do
		assert_raises ArgumentError do
		 	Feature.create!({
		 		feature_type: :whatever,
		 		product: products(:product1),
		 		feature_label: feature_labels(:label1)
		 	})
		end
	end
	test 'has_feature_option? returns true for a feature_option_id included' do
		assert(@f.has_feature_option?(@fo1.id), "#{@fo1.id} is included at #{@f.feature_option_ids}")
	end
	test 'has_feature_option? returns false for a feature_option_id not included' do
		refute(@f.has_feature_option?(@fo2.id), "#{@fo2.id} is NOT included at #{@f.feature_option_ids}")
	end
	test 'get_feature_option_for returns same feature_option passed' do
		assert_equal(@fo1,@f.get_feature_option_for(@fo1.id), "#{@fo1} exists in #{@f.feature_options}")
	end
	test 'get_feature_option_for returns nil for a non-existing feature_option' do
		assert_nil(@f.get_feature_option_for(@fo2.id), "#{@fo2} NOT exists in #{@f.feature_options}")
	end
	test 'should return a hash for feature_options_to_hash' do
		h = @f.feature_options_to_hash()
		assert(h.is_a?(Hash))
	end
	test 'every featureOption id exist as key for feature_options_to_hash' do
		h = @f.feature_options_to_hash()
	  	@f.feature_options.each do |fo|
	  		assert(h.has_key?("#{fo.id}"))
	  	end
	end
	test 'as_json returns the attributes specified at serializable_hash' do
		feature_hash = @f.as_json()
		keys = feature_hash.keys()
		assert_includes(keys, 'id')
		assert_includes(keys, 'feature_type')
		assert_includes(keys, 'feature_label')
		assert_includes(keys, 'feature_options')
	end
	test 'as_json returns a hash for the feature_options key' do
		feature_hash = @f.as_json()
		if feature_hash.key?('feature_options')
			assert(feature_hash['feature_options'].is_a?(Hash))
		end
	end
end