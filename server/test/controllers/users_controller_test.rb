require 'test_helper'
require 'json'

class UsersControllerTest < ActionDispatch::IntegrationTest
	setup do
		@user = users(:user1)
	end
	test 'should get forbidden for an already signed in user' do
		post sign_in_path, params: { user: { email: @user.email, password: 'secret_password' } }
		body_hash = JSON.parse(response.body)
		post sign_in_path, headers: { 'Authorization' => 'Token token='+body_hash['token'] }
		body_hash = JSON.parse(response.body)
		assert_response :forbidden
		assert_equal('already signed in', body_hash['detail'])
	end
	test 'should get bad request for missing user parameters' do
		post sign_in_path
		body_hash = JSON.parse(response.body)
		assert_response :bad_request
		assert_equal('param is missing or the value is empty: user', body_hash['detail'])

		post sign_in_path, params: { user: {} }
		body_hash = JSON.parse(response.body)
		assert_response :bad_request
		assert_equal('param is missing or the value is empty: user', body_hash['detail'])

		post sign_in_path, params: { user: { email: 'anyone@anywhere.com' } }
		body_hash = JSON.parse(response.body)
		assert_response :bad_request
		assert_equal('param is missing or the value is empty: password', body_hash['detail'])

		post sign_in_path, params: { user: { password: 'secret_password' } }
		body_hash = JSON.parse(response.body)
		assert_response :bad_request
		assert_equal('param is missing or the value is empty: email', body_hash['detail'])
	end
	test 'should get forbidden for unexistent user email' do
		post sign_in_path, params: { user: { email: 'anyone@anywhere.com', password: 'secret_password' } }
		body_hash = JSON.parse(response.body)
		assert_response :forbidden
		assert_equal('email or password not valid', body_hash['detail'])
	end
	test 'should get forbidden for a non-valid password' do
		post sign_in_path, params: { user: { email: 'someone@somewhere.com', password: 'secret_password2'} }
		body_hash = JSON.parse(response.body)
		assert_response :forbidden
		assert_equal('email or password not valid', body_hash['detail'])
	end
	test 'should get success for a email/password valid' do
		post sign_in_path, params: { user: { email: @user.email, password: 'secret_password' } }
		body_hash = JSON.parse(response.body)
		assert_response :ok
		refute_nil(body_hash['token'])
	end
	test 'should get unauthorized when trying to delete token' do
		delete sign_out_path
		body_hash = JSON.parse(response.body)
		assert_response :unauthorized
		assert_equal('Access denied', body_hash['detail'])
	end
	test 'should get success when trying to delete a token' do
		post sign_in_path, params: { user: { email: @user.email, password: 'secret_password'} }
		body_hash = JSON.parse(response.body)
		delete sign_out_path, headers: { 'Authorization' => 'Token token='+body_hash['token'] }
		assert_response :no_content
	end
end
