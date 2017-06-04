require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
	setup do
		@customer = customers(:customer1)
	end
	test 'as_json returns every attribute except created_at and updated_at' do
		customer_hash = @customer.as_json()
		keys = customer_hash.keys()
		assert_includes(keys, 'company_name')
		assert_includes(keys, 'address')
		assert_includes(keys, 'telephone')
		assert_includes(keys, 'email')
		assert_includes(keys, 'contact_name')
		assert_includes(keys, 'contact_surname')
		refute_includes(keys, 'created_at')
		refute_includes(keys, 'updated_at')
	end
end