class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!

  respond_to :json

  private

  def authenticate_user!
    return true if current_user
    auth = Rack::Auth::Basic::Request.new(env)
    return unauthorized unless (auth.provided? ||request.headers['Authorization-Token'])
    token = (auth.provided? && auth.credentials[0]) || request.headers['Authorization-Token']
    if user = User.find_by(authentication_token: token)
      sign_in user, store: false
    else
      unauthorized
    end
  end

  def bad_request
    payload = {
      message: 'Bad request',
      code: 400
    }
    render json: payload, status: 400 and return
  end

  def unauthorized
    payload = {
      message: 'Unauthorized request',
      error: 'unauthorized',
      code: 401
    }
    render json: payload, status: 401 and return
  end
end
