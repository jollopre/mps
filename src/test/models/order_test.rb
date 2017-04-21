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
end
