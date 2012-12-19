class Suggestion < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :venue
  belongs_to :plan
end
