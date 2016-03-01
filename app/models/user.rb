class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authentications

  # From Matt. WORKS. Not used anymore here, as follow Railscast #236 by over-riding Devise email and password validations
  # def self.from_omniauth(auth)
  #   # Was: Authentication.find_or_create_by(auth.slice(:provider, :uid)) do |authentication|
  #   Authentication.find_or_create_by(provider: auth.provider, uid: auth.uid) do |authentication|
  #     authentication.provider = auth.provider
  #     authentication.uid = auth.uid
  #     authentication.name = auth.info.name
  #     authentication.image = auth.info.image
  #     authentication.location = auth.info.location
  #     authentication.url = auth.info.urls.Twitter
  #     authentication.user = User.new(email: "email@email.com", password: "password", password_confirmation: "password") # Does not over-come Devise validations here
  #   end
  # end

  # From Railscast #235 Devise and Omniauth Part 1 (Revised)
  # def self.from_omniauth(auth)
  #   # From GoRails
  #   # user = where(provider: auth.provider, uid: auth.uid).first_or_create
  #   # user.update(name: auth.info.name, profile_image: auth.info.image, token: auth.credentials.token, secret: auth.credentials.secret)
  #   # user
  #
  #   where(auth.slice(:provider, :uid)).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.name = auth.info.name
  #   end
  # end
  #
  # From Railscast #236
  def apply_omniauth(omniauth)
    # self.email = omniauth['info']['email'] if email.blank? # Twitter does not return an email
    authentications.build(provider: omniauth["provider"], uid: omniauth["uid"])
  end

  # From Railscast #235 (Revised)
  def self.new_with_session(params, session) # Needs this method so that when super is called,
                                             # validations are still called and will show the error messages in the views
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  #
  # From Railscast #235 (Revised)
  # def password_required?
  #   super && provider.blank?
  # end
  #
  # def email_required?
  # end
  #
  # From Railscast #235 (Revised)
  # Method to not require current password when updating user profile
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end


  # From Railscast #236
  def password_required? # Want this to return false, so password validation is not required
    (authentications.empty? || !password.blank?) && super
  end

end
