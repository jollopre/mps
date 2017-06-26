class ApplicationController < ActionController::API
	include ActionController::Helpers
	include ActionController::HttpAuthentication::Token::ControllerMethods
	before_action :require_login
	helper_method :current_user

	def require_login
		render json: { detail: 'Access denied' }, status: :unauthorized unless user_from_token
	end

	def current_user
		@current_user ||= user_from_token
	end

	private
		# Returns the first User matching the token passed or nil if none is found
		def user_from_token
			authenticate_with_http_token do |token, options|
				User.find_by(token: token)
			end
		end
end
