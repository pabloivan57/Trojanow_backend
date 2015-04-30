class UsersController < ApiController
  skip_before_filter :authenticate_user!, only: [:create]
  respond_to :json

  def create
    user = User.create({
                         email: params[:email],
                         password: params[:password],
                         password_confirmation: params[:password_confirmation],
                         fullname: params[:fullname]
                       })
    if user.save
      render :json => user.as_json, status: :created
    else
      warden.custom_failure!
      render :json => user.errors, status: :unprocessable_entity
    end
  end

  def update
    user = current_user
    user.skip_reconfirmation!
    if user.update_attributes(user_params)
      render :json => user.as_json, status: :ok
    else
      warden.custom_failure!
      render :json => user.errors, status: :unprocessable_entity
    end
  end

  private
end
