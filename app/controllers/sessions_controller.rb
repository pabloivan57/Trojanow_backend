class SessionsController < ApiController
  skip_before_filter :authenticate_user!

  def create
    @user = user_login
    return invalid_login_attempt unless @user
    render json: @user
  end

  private

  def user_login
    user = User.find_for_database_authentication(email: params[:email])
    return user if user && user.valid_password?(params[:password])
  end

  def user_params
    params.permit(:email, :password)
  end

  def invalid_login_attempt
    warden.custom_failure!
    render json: { sucess: false, message: "Error with login or password" }, status: :unauthorized
  end
end
