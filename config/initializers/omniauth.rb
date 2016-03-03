OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']
                      # :scope => 'email,public_profile,user_friends' # See https://developers.facebook.com/docs/facebook-login/permissions
end
