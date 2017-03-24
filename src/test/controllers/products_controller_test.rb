require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'should get success for index action' do
  	get products_path
  	assert_response :success
  end
  test 'should get success for show action' do
  	get product_path('1')
  	assert_response :success
  end
  test 'should get not_found for show action' do
  	get product_path('10000')
  	assert_response :not_found
  end
end
