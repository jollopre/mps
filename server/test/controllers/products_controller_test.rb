require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:product1)
    @user = users(:user1)
  end
  test 'should get success for index action' do
  	get products_path, headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :ok
  end
  test 'should get success for show action' do
  	get product_path(@product.id), headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :ok
  end
  test 'should get not_found for show action' do
  	get product_path('10000'), headers: { 'Authorization' => 'Token token='+@user.token }
  	assert_response :not_found
  end
end
