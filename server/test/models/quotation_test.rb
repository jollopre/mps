require 'test_helper'

class QuotationTest < ActiveSupport::TestCase
	setup do
		@q = quotations(:quotation1)
	end

	test 'should return a hash for enquiries_to_hash' do
		h = @q.enquiries_to_hash()
		assert(h.is_a?(Hash))
	end
	test 'every enquiry id exists as key for enquiries_to_hash' do
		h = @q.enquiries_to_hash()
		@q.enquiries.each do |oi|
			assert(h.has_key?("#{oi.id}"))
		end
	end
	test 'as_json returns every attribute specified at serializable_hash' do
		quotation_hash = @q.as_json()
		keys = quotation_hash.keys()
		assert_includes(keys, 'created_at')
		assert_includes(keys, 'updated_at')
		assert_includes(keys, 'customer_id')
		assert_includes(keys, 'enquiry_ids')
	end
	test 'as_json returns a hash for the enquiries key' do
		quotation_hash = @q.as_json()
		if quotation_hash.key?('enquiries')
			assert(quotation_hash['enquiries'].is_a?(Hash))
		end
	end
end
