require 'test_helper'

class ComposedEmailsControllerTest < ActionDispatch::IntegrationTest
	test '#create should return bad request when any parameter is missing' do
		params = {
			composed_email: {},
			subject: { composed_email: { subject: nil }},
			body: { composed_email: { subject: 'subject' }},
			enquiry_ids: { composed_email: { subject: 'subject', body: 'body' } },
			supplier_ids: { composed_email: { subject: 'subject', body: 'body', enquiry_ids: [1] }}
		}
		params.each_pair do |k,v|
			post composed_emails_path(params: v), headers: auth_header
			assert_response :bad_request
			assert_equal("param is missing or the value is empty: #{k}", fetch_detail(response.body))
		end
	end

	test '#create should return bad request when enquiry or supplier does not exist' do
		enquiry = enquiries(:enquiry1)
		supplier = suppliers(:supplier1)
		params = {
			Enquiry: { composed_email: { subject: 'subject', body: 'body', enquiry_ids: [-1], supplier_ids: [supplier.id] }},
			Supplier: { composed_email: { subject: 'subject', body: 'body', enquiry_ids: [enquiry.id], supplier_ids: [-1] }},
		}
		params.each_pair do |k,v|
			post composed_emails_path(params: v), headers: auth_header
			assert_response :bad_request
			assert_equal("Couldn't find #{k} with 'id'=[-1]", fetch_detail(response.body))
		end
	end

	test '#create should return success for a valid composed_email passed' do
		enquiry = enquiries(:enquiry1)
		supplier = suppliers(:supplier1)
		post composed_emails_path(params: {
			composed_email: {
				subject: 'subject', body: 'body', enquiry_ids: [enquiry.id], supplier_ids: [supplier.id] }}), headers: auth_header
		assert_response :created
		puts response.header
	end

	def fetch_detail(value)
		ActiveSupport::JSON.decode(value).fetch('detail')
	end
end
