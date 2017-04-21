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
end
