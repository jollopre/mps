require 'test_helper'

class QuotationTest < ActiveSupport::TestCase
	setup do
		@q = quotations(:quotation1)
	end

	test 'should return a hash for order_items_to_hash' do
		h = @q.order_items_to_hash()
		assert(h.is_a?(Hash))
	end
	test 'every order_item id exists as key for order_items_to_hash' do
		h = @q.order_items_to_hash()
		@q.order_items.each do |oi|
			assert(h.has_key?("#{oi.id}"))
		end
	end
	test 'as_json returns every attribute specified at serializable_hash' do
		quotation_hash = @q.as_json()
		keys = quotation_hash.keys()
		assert_includes(keys, 'created_at')
		assert_includes(keys, 'updated_at')
		assert_includes(keys, 'customer_id')
		assert_includes(keys, 'order_item_ids')
	end
	test 'as_json returns a hash for the order_items key' do
		quotation_hash = @q.as_json()
		if quotation_hash.key?('order_items')
			assert(quotation_hash['order_items'].is_a?(Hash))
		end
	end
end
