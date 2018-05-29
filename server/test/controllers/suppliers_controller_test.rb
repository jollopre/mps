require 'test_helper'

class SuppliersControllerTest < ActionDispatch::IntegrationTest
	test 'should get success for index action' do
		get suppliers_path, headers: auth_header
		assert_response :ok
		expected = ActiveSupport::JSON.decode(
			ActiveSupport::JSON.encode([suppliers(:supplier1), suppliers(:supplier2)]))
		assert_equal(expected, ActiveSupport::JSON.decode(response.body))
	end
end
