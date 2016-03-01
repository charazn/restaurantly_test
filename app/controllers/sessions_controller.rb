# No longer used when authenticate with Devise and Omniauth
# class SessionsController < ApplicationController

#   def create
#     auth = request.env["omniauth.auth"]
#     render :text => auth.to_yaml # + View Source. To better see the returned hash.
#     # user = User.find_by(provider: auth["provider"], uid: auth["uid"]) || User.create_with_omniauth(auth)
#     # session[:user_id] = user.id
#     # redirect_to root_path, :notice => "Signed In"
#   end

#   def destroy
#     session[:user_id] = nil
#     redirect_to root_path, :notice => "Signed Out"
#   end
# end
