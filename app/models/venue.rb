class Venue < ActiveRecord::Base
  attr_accessible :address, :image, :name, :website

  has_many :suggestions
  has_many :plans, :through => :suggestions

##  has_and_belongs_to_many :plans
##  has_many :points, :through => :plans
end
