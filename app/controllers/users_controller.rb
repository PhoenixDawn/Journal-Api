class UsersController < ApplicationController
  def login
    user = User.find_by_email(user_params[:email])
    if user && user.authenticate(user_params[:password])
      payload = { email: user.email, exp: Time.now.to_i + 4 * 3600 } #set expiry for 4 hours
      token = JWT.encode(payload, @@jwt_secret, "HS512")
      render json: { token: token }
    else
      render json: { error: "Email and Password do not match" }, status: 403
    end
  end

  def register
    render json: User.create(get_user_params)
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
