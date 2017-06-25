require 'test_helper'

class UserTest < ActiveSupport::TestCase
	require 'digest/sha2'
	setup do
		@user = users(:user1)
	end
	test 'valid_password is true' do
		assert(@user.valid_password?('secret_password'))
	end
	test 'valid password is false' do
		refute(@user.valid_password?('secret_password2'))
	end
	test 'save raises ActiveRecord::RecordInvalid exception when email or password are not present' do
		user = User.new({ name: 'Name', surname: 'Surname'})
		err = assert_raises ActiveRecord::RecordInvalid do
			user.save!
		end
		assert_match(/Validation failed: Email can\'t be blank, Password can\'t be blank/, err.message)
	end
	test 'password is encrypted before being saved' do
		@user.password = 'secret_password2'
		exp = Digest::SHA2.hexdigest(@user.password)
		@user.save
		assert_equal(exp, @user.password)
	end
	test 'generate_token persist a new SecureRandom token' do
		token = @user.generate_token()
		refute_nil(@user.token)
		assert_equal(token, @user.token)
	end
	test 'invalidate_token persist a nil token' do
		@user.generate_token()
		refute_nil(@user.token)
		@user.invalidate_token()
		assert_nil(@user.token)
	end
end
