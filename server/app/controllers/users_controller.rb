class UsersController < ApplicationController
	skip_before_action :require_login, only: [:sign_in]
	# POST /api/sign-in
	def sign_in
		if current_user
			render json: { detail: 'already signed in' }, status: :forbidden
			return false
		end
		begin
			permitted = sign_in_params()
			user = User.find_by!(email: permitted[:email])
			if user.valid_password?(permitted[:password])
				token = user.generate_token()
				if token
					render json: { token: token }, status: :ok
				else
					render json: { detail: 'error generating token' }, status: :internal_server_error
				end
			else
				render json: { detail: 'email or password not valid' }, status: :forbidden
			end
		rescue ActionController::ParameterMissing => e
			render json: { detail: e.message }, status: :bad_request
		rescue ActiveRecord::RecordNotFound => e
			render json: { detail: 'email or password not valid' }, status: :forbidden
		end
	end
	# DELETE /api/sign-out
	def sign_out
		if current_user
			result = current_user.invalidate_token()
			if result
				head :no_content
			else
				render json: { detail: 'error destroying token' }, status: :internal_server_error
			end
		end
	end
	private
		# Check whether or not the required params are present. The absence of any raises
		# ActionController::ParameterMissing
		def sign_in_params
			params.require(:user).tap do |user|
				user.require([:email, :password])
			end 
		end
end
