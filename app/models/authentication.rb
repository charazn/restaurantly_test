class Authentication < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true
  belongs_to :user
end
