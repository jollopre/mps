require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user1)
    @customer = customers(:customer1)
  end
  test 'should get success at index action' do
    get customers_path, headers: { 'Authorization' => 'Token token='+@user.token }
    assert_response :ok
    customers = ActiveSupport::JSON.decode(response.body)
    assert_equal(2, customers['meta']['count'], 'There is only two customers')
    assert_equal(Kaminari.config.default_per_page, customers['meta']['per_page'])
    refute_nil(customers['data'])
  end
  test 'should get not found at show action' do
    get customer_path(10000), headers: { 'Authorization' => 'Token token='+@user.token }
    assert_response :not_found
  end
  test 'should get success at show action' do
    get customer_path(@customer), headers: { 'Authorization' => 'Token token='+@user.token }
    assert_response :ok
  end
  test 'should get the expected keys at show action' do
    get customer_path(@customer), headers: { 'Authorization' => 'Token token='+@user.token }
    customer = ActiveSupport::JSON.decode(response.body)
    keys = [:id, :reference, :company_name, :address, :telephone, :email, :contact_name, :contact_surname]
    keys.each{ |k| assert customer.has_key?(k.to_s) }
  end
end