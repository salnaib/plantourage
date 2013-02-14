class User < ActiveRecord::Base
  attr_accessible :uid, :name

  has_many :plans, :as => :organizer
  has_many :invites
  has_many :plans, :through => :invites

##  has_and_belongs_to_many :plans
##  has_many :points, :through => :plans

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.save!
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    end
  end

end
