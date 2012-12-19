class User < ActiveRecord::Base
  attr_accessible :fbid

  has_many :plans, :as => :organizer

##  has_and_belongs_to_many :plans
##  has_many :points, :through => :plans
end
