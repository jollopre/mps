require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
	setup do
		@customer = customers(:customer1)
		@order = orders(:order1)
		@user = users(:user1)
	end
	
	# POST /orders with body { "order": { "customer_id": number }}
	test 'should get bad request for missing parameters at create action' do
		post orders_path, params: {order: {}}, headers: { 'Authorization' => 'Token token='+@user.token }
		assert_response :bad_request
	end
	test 'should get bad request for invalid data at create action' do
		post orders_path, params: {order: {customer_id: 10000}}, headers: { 'Authorization' => 'Token token='+@user.token }
		assert_response :bad_request
	end
	test 'should get created for valid data at create action' do
		post orders_path, params: {order: {customer_id: @customer.id}}, headers: { 'Authorization' => 'Token token='+@user.token }
		assert_response :created
	end

	# GET /orders
	test 'should get success at index action' do
		get orders_path, headers: { 'Authorization' => 'Token token='+@user.token }
  		assert_response :ok
	end

	# GET /orders?customer_id
	test 'should get success at index action for customer1' do
		get orders_path({ customer_id: @customer.id }), headers: { 'Authorization' => 'Token token='+@user.token }
  		assert_response :ok
  		orders = JSON.parse(response.body)
  		assert_equal(2, orders.length, "There is only two orders for the customer1")
	end

	# GET /orders?customer_id
	test 'should get success at index action for customer2' do
		get orders_path({ customer_id: customers(:customer2).id }), headers: { 'Authorization' => 'Token token='+@user.token }
  		assert_response :ok
  		orders = JSON.parse(response.body)
  		assert_equal(1, orders.length, "There is only one order for the customer2")
	end

	# GET /orders/:id
	test 'should get not found at show action' do
		get order_path(10000), headers: { 'Authorization' => 'Token token='+@user.token }
  		assert_response :not_found
	end
	test 'should get success at show action' do
		get order_path(@order.id), headers: { 'Authorization' => 'Token token='+@user.token }
  		assert_response :ok
	end

end
