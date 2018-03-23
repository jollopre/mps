require 'test_helper'

class QuotationsControllerTest < ActionDispatch::IntegrationTest
	setup do
		@customer = customers(:customer1)
		@quotation = quotations(:quotation1)
		@user = users(:user1)
	end
	
	# POST /quotations with body { "quotation": { "customer_id": number }}
	test 'should get bad request for missing parameters at create action' do
		post quotations_path, params: {quotation: {}}, headers: { 'Authorization' => 'Token token='+@user.token }
		assert_response :bad_request
	end
	test 'should get bad request for invalid data at create action' do
		post quotations_path, params: {quotation: {customer_id: 10000}}, headers: { 'Authorization' => 'Token token='+@user.token }
		assert_response :bad_request
	end
	test 'should get created for valid data at create action' do
		post quotations_path, params: {quotation: {customer_id: @customer.id}}, headers: { 'Authorization' => 'Token token='+@user.token }
		assert_response :created
	end

	# GET /quotations
	test 'should get bad request s at index action when customer_id is missing' do
		get quotations_path, headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :bad_request
  	error = ActiveSupport::JSON.decode(response.body)
  	assert_equal(error['detail'], 'param is missing or the value is empty: customer_id')
	end

	# GET /quotations?customer_id
	test 'should get success at index action for customer1' do
		get quotations_path({ customer_id: @customer.id }), headers: { 'Authorization' => 'Token token='+@user.token }
  		assert_response :ok
  		quotations = JSON.parse(response.body)
  		assert_equal(2, quotations['meta']['count'], "There is only two quotations for the customer1")
  		assert_equal(Kaminari.config.default_per_page, quotations['meta']['per_page'])
  		refute_nil(quotations['data'])
	end

	# GET /quotations?customer_id
	test 'should get success at index action for customer2' do
		get quotations_path({ customer_id: customers(:customer2).id }), headers: { 'Authorization' => 'Token token='+@user.token }
  		assert_response :ok
  		quotations = JSON.parse(response.body)
  		assert_equal(1, quotations['meta']['count'], "There is only one quotation for the customer2")
  		assert_equal(Kaminari.config.default_per_page, quotations['meta']['per_page'])
  		refute_nil(quotations['data'])
	end

	# GET /quotations/:id
	test 'should get not found at show action' do
		get quotation_path(10000), headers: { 'Authorization' => 'Token token='+@user.token }
  		assert_response :not_found
	end
	test 'should get success at show action' do
		get quotation_path(@quotation.id), headers: { 'Authorization' => 'Token token='+@user.token }
  		assert_response :ok
	end

end
