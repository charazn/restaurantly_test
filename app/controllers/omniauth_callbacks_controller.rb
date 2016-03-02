class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by(provider: omniauth.provider, uid: omniauth.uid)
    if authentication
      flash[:notice] = "Authentication successful"
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(provider: omniauth.provider, uid: omniauth.uid)
      flash[:notice] = "Authentication successful"
      redirect_to authentications_path
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save # if user.save! and user.save(validate: false) but not recommended
        flash[:notice] = "Authentication successful"
        sign_in_and_redirect(:user, user)
      else
        session["devise.user_attributes"] = user.attributes # Not necessary to set this session
        session[:omniauth] = omniauth.except("extra")
        redirect_to new_user_registration_path
      end
    end
  end

  alias_method :twitter, :all

end
