class Suggestion < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :venue
  belongs_to :plan
  has_many :points

  def pointcount
    return Point.sum(:count, :conditions => ['suggestion_id = ?', self.id])
  end

end
