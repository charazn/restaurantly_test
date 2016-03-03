class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    omniauth = request.env["omniauth.auth"]
    auth = Authentication.find_by(provider: omniauth.provider, uid: omniauth.uid)
    if auth
      flash[:notice] = "Authentication successful"
      sign_in(auth.user)
      redirect_to authentications_path
      # sign_in_and_redirect(:user, auth.user)
    elsif current_user
      save_auth(omniauth, current_user)
      flash[:notice] = "Authentication successful"
      redirect_to authentications_path
    else
      new_user = User.new
      save_auth(omniauth, new_user)

      if new_user.save
        flash[:notice] = "Authentication successful"
        # sign_in_and_redirect(:user, new_user)
        sign_in(auth.user)
        redirect_to authentications_path
      else
        session["devise.user_attributes"] = new_user.attributes
        session[:omniauth] = omniauth.except("extra")
        redirect_to new_user_registration_path
      end
    end
  end

  alias_method :twitter, :all
  alias_method :facebook, :all

  private

  def save_auth(omniauth, user)
    if omniauth.provider == "facebook"
      user.build_facebook_auth(omniauth)
      user.email = "#{omniauth.info.name.downcase.delete(' ')}@facebook.com"
      user.save!
    else omniauth.provider == "twitter"
      user.build_twitter_auth(omniauth)
      user.email = "#{omniauth.info.name.downcase.delete(' ')}@twitter.com"
      user.save!
    end
  end

end
