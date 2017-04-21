require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  	setup do
		@f = features(:feature3)
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
end
