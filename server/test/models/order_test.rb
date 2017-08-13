require 'test_helper'

class OrderTest < ActiveSupport::TestCase
	setup do
		@o = orders(:order1)
	end

	test 'should return a hash for order_items_to_hash' do
		h = @o.order_items_to_hash()
		assert(h.is_a?(Hash))
	end
	test 'every order_item id exists as key for order_items_to_hash' do
		h = @o.order_items_to_hash()
		@o.order_items.each do |oi|
			assert(h.has_key?("#{oi.id}"))
		end
	end
	test 'as_json returns every attribute specified at serializable_hash' do
		order_hash = @o.as_json()
		keys = order_hash.keys()
		assert_includes(keys, 'created_at')
		assert_includes(keys, 'updated_at')
		assert_includes(keys, 'customer_id')
		assert_includes(keys, 'order_item_ids')
	end
	test 'as_json returns a hash for the order_items key' do
		order_hash = @o.as_json()
		if order_hash.key?('order_items')
			assert(order_hash['order_items'].is_a?(Hash))
		end
	end
end
