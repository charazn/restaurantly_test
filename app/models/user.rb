class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authentications

  def apply_omniauth(omniauth)
    authentications.build(provider: omniauth["provider"], uid: omniauth["uid"])
  end

  def build_facebook_auth(omniauth)
    authentications.build(
      provider: omniauth.provider,
      uid: omniauth.uid,
      name: omniauth.info.name,
      image: omniauth.info.image,
      # location: omniauth.info.location,
      # url: omniauth.info.urls.Facebook,
      token: omniauth.credentials.token,
      expires_at: Time.zone.at(omniauth.credentials.expires_at)
    )
  end

  def build_twitter_auth(omniauth)
    authentications.build(
      provider: omniauth.provider,
      uid: omniauth.uid,
      name: omniauth.info.name,
      image: omniauth.info.image,
      location: omniauth.info.location,
      url: omniauth.info.urls.Twitter,
      token: omniauth.credentials.token,
      secret: omniauth.credentials.secret
    )
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

end
