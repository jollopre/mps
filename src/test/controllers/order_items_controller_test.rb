require 'test_helper'

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
  	# Following instance variables are created according to the values stored in fixtures orders.yml, etc ...
  	@order = orders(:order1)
  	@product = products(:product1)
  	@order_item = order_items(:order_item1)
  end

  # GET /orders/:order_id/order_items
  test 'should get success at index action' do
  	get order_order_items_path(@order.id)
  	assert_response :ok
  end

  # POST /orders/:order_id/order_items
  test 'should get bad request for missing parameters at create action' do
  	post order_order_items_path(@order.id), params: {order_item: {}}
  	assert_response :bad_request
  end
  test 'should get bad request for invalid data at create action (quantity as float)' do
  	post order_order_items_path(@order.id), params: {order_item: {product_id: @product.id, quantity: 1.2}}
  	assert_response :bad_request
  end
  test 'should get bad request for invalid data at create action (quantity as string)' do
  	post order_order_items_path(@order.id), params: {order_item: {product_id: @product.id, quantity: 'aaa'}}
  	assert_response :bad_request
  end
  test 'should get no content for valid data at create action (quantity param missed)' do
  	post order_order_items_path(@order.id), params: {order_item: {product_id: @product.id}}
  	assert_response :no_content
  end
  test 'should get no content for valid data at create action (quantity param as integer)' do
  	post order_order_items_path(@order.id), params: {order_item: {product_id: @product.id, quantity: 2}}
  	assert_response :no_content
  end

  # GET /order_items/:id
  test 'should get not found at show action' do
  	get order_item_path(10000)
  	assert_response :not_found
  end
  test 'should get no content at show action' do
  	get order_item_path(@order_item.id)
  	assert_response :ok
  end
  
  # PATCH/PUT /order_items/:id
  test 'should get bad request for missing parameters at update action' do
  	put order_item_path(@order_item.id), params: {order_item: {}}
  	assert_response :bad_request
  end
  test 'should get not found at update action' do
  	put order_item_path(10000), params: {order_item: {quantity: 2}}
  	assert_response :not_found
  end
  test 'should get bad request for invalid data at update action (quantity as string)' do
  	put order_item_path(@order_item.id), params: {order_item: {quantity: 'aaa'}}
  	assert_response :bad_request
  end
  test 'should get success at update action' do
  	put order_item_path(@order_item.id), params: {order_item: {quantity: 1000}}
  	assert_response :ok
  end
end
