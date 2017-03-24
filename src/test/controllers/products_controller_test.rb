require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'should get success for existent product' do
  	get product_path('1')
  	assert_response :success
  end
  test 'should get not_found for non-existent product' do
  	get product_path('10000')
  	assert_response :not_found
  end
end
