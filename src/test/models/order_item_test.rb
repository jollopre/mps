require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
	setup do
		@oi = order_items(:order_item1)
	end
	test 'should return a hash for feature_values_to_hash' do
		h = @oi.feature_values_to_hash()
		assert(h.is_a?(Hash))
	end
	test 'every feature_value id exist as key for feature_values_to_hash' do
		h = @oi.feature_values_to_hash()
	  	@oi.feature_values.each do |fv|
	  		assert(h.has_key?("#{fv.id}"))
	  	end
	end
end
