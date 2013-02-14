class Point < ActiveRecord::Base
  attr_accessible :count

  belongs_to :user
  belongs_to :venue
  belongs_to :plan

##  belongs_to :plan
##  has_one :venue , :through => :plans
##  has_one :user, :through => :plans
end
