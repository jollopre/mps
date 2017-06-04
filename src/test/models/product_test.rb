require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  	setup do
		@p = products(:product1)
	end
	test 'should return a hash for features_to_hash' do
		h = @p.features_to_hash()
		assert(h.is_a?(Hash))
	end
	test 'every feature id exist as key for features_to_hash' do
		h = @p.features_to_hash()
	  	@p.features.each do |f|
	  		assert(h.has_key?("#{f.id}"))
	  	end
	end
	test 'as_json returns every attribute specified at serializable_hash' do
		product_hash = @p.as_json()
		keys = product_hash.keys()
		assert_includes(keys, 'id')
		assert_includes(keys, 'name')
		assert_includes(keys, 'features')
	end
	test 'as_json returns a hash for the feature key' do
		product_hash = @p.as_json()
		if product_hash.key?('features')
			assert(product_hash['features'].is_a?(Hash))
		end
	end
end