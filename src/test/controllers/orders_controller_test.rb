require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
	setup do
		@customer = customers(:customer1)
		@order = orders(:order1)
	end
	
	# POST /orders with body { "order": { "customer_id": number }}
	test 'should get bad request for missing parameters at create action' do
		post orders_path, params: {order: {}}
		assert_response :bad_request
	end
	test 'should get bad request for invalid data at create action' do
		post orders_path, params: {order: {customer_id: 10000}}
		assert_response :bad_request
	end
	test 'should get created for valid data at create action' do
		post orders_path, params: {order: {customer_id: @customer.id}}
		assert_response :created
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
		get order_path(@order.id)
  		assert_response :ok
	end

end
