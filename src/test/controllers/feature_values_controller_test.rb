require 'test_helper'

class FeatureValuesControllerTest < ActionDispatch::IntegrationTest
	setup do
		@feature_value_float = feature_values(:fv_float)
		@feature_value_integer = feature_values(:fv_integer)
		@feature_value_option = feature_values(:fv_option)
		@feature_value_string = feature_values(:fv_string)
		@feature_option1 = feature_options(:feature_option1)
		@feature_option2 = feature_options(:feature_option2)
	end
	test 'should get bad request for missing parameter at update action' do
		put feature_value_path(@feature_value_float.id), params: {feature_value: {}}
		assert_response :bad_request
	end
	test 'should get not found at update action' do
		put feature_value_path(10000), params: {feature_value: {value: ''}}
		assert_response :not_found
	end
	test 'should get bad request for invalid data at update action (expected float)' do
		put feature_value_path(@feature_value_float.id), params: {feature_value: {value: 'whatever'}}
		assert_response :bad_request
	end
	test 'should get bad request for invalid data at update action (expect integer)' do
		put feature_value_path(@feature_value_integer.id), params: {feature_value: {value: 'whatever'}}
		assert_response :bad_request
	end
	test 'should get bad request for invalid data at update action (expect integer for option id)' do
		put feature_value_path(@feature_value_option.id), params: {feature_value: {value: @feature_option2.id}}
		assert_response :bad_request
	end
	test 'should get success at update action' do
		put feature_value_path(@feature_value_float.id), params: {feature_value: {value: '3.14'}}
		assert_response :ok
		put feature_value_path(@feature_value_integer.id), params: {feature_value: {value: '3'}}
		assert_response :ok
		put feature_value_path(@feature_value_option.id), params: {feature_value: {value: @feature_option1.id}}
		assert_response :ok
		put feature_value_path(@feature_value_string.id), params: {feature_value: {value: 'New String value'}}
		assert_response :ok
	end
end