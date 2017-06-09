class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # before_action :debug
  def valkyrie    
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Valkyrie") if is_navigational_format?
    else
      session["devise.valkyrie"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  # def failure
  #   raise env
  # end

  # def debug
  #   raise env.inspect
  # end
end
