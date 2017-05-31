class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # byebug
  # auth = request.env['omniauth.auth']
  # render json: auth.to_json
end
