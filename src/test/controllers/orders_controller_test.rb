require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
	# POST /orders with body { "order": { "customer_id": number }}
	test 'should get bad request for missing parameters at create action' do
		post orders_path, params: {order: {}}
		assert_response :bad_request
	end
	test 'should get bad request for invalid data at create action' do
		post orders_path, params: {order: {customer_id: 10000}}
		assert_response :bad_request
	end
	test 'should get no content for valid data at create action' do
		post orders_path, params: {order: {customer_id: 1}}
		assert_response :no_content
	end

	# GET /orders
	test 'should get success at index action' do
		get orders_path
  		assert_response :ok
	end

	# GET /orders/:id
	test 'should get not found at show action' do
		get order_path(10000)
  		assert_response :not_found
	end
	test 'should get success at show action' do
		get order_path(1)
  		assert_response :ok
	end

end
