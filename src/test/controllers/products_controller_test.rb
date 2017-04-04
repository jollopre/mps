require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:product1)
  end
  test 'should get success for index action' do
  	get products_path
  	assert_response :ok
  end
  test 'should get success for show action' do
  	get product_path(@product.id)
  	assert_response :ok
  end
  test 'should get not_found for show action' do
  	get product_path('10000')
  	assert_response :not_found
  end
end
