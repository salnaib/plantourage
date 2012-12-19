class Venue < ActiveRecord::Base
  attr_accessible :address, :image, :name, :website

##  has_and_belongs_to_many :plans
##  has_many :points, :through => :plans
end
