class ApplicationController < ActionController::Base
  include NotificationHandlerController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit
  # byebug
  # auth = request.env['omniauth.auth']
  # render json: auth.to_json
  def user_for_paper_trail
    user_signed_in? ? current_user.email : 'Non Human'
  end
end
