class UsersController < ApplicationController
  skip_before_action :require_login, only: [:sign_in]
  # POST /api/sign-in
  def sign_in
    render json: { detail: 'already signed in' }, status: :unprocessable_entity and return if current_user

    permitted = sign_in_params
    user = User.find_by!(email: permitted[:email])

    if user.valid_password?(permitted[:password])
      token = user.generate_token()
      render json: { token: token }, status: :ok
    else
      errors = ErrorsService.do(OpenStruct.new(errors: ['email or password not valid'], status: 401))
      render json: errors, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound => e
    errors = ErrorsService.do(OpenStruct.new(errors: ['email or password not valid'], status: 401))
    render json: errors, status: :unauthorized
  end

  # DELETE /api/sign-out
  def sign_out
    result = current_user.invalidate_token()
    head :no_content and return if result

    errors = ErrorsService.do(OpenStruct.new(errors: ['error destroying token'], status: 422))
    render json: errors, status: :unprocessable_entity
  end

  private

  def sign_in_params
    params.require(:user).tap do |user|
      user.require([:email, :password])
    end
  end
end
