require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
    setup do
        @user = users(:user1)
    end
    test 'should get success at index action' do
        get customers_path, headers: { 'Authorization' => 'Token token='+@user.token }
        assert_response :ok
    end
end