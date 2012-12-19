class Plan < ActiveRecord::Base
  attr_accessible :name, :plandate

  has_many :suggestions
  has_many :venues, :through => :suggestions
  has_many :invites
  has_many :users, :through => :invites
  belongs_to :organizer, :polymorphic => true

##  has_and_belongs_to_many :users
##  has_and_belongs_to_many :venues
##  has_many :points
end
