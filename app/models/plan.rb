class Plan < ActiveRecord::Base
  attr_accessible :name, :plandate

  has_many :suggestions
  has_many :venues, :through => :suggestions
  has_many :invites
  has_many :users, :through => :invites
  belongs_to :organizer, :polymorphic => true
  has_many :points

##  has_and_belongs_to_many :users
##  has_and_belongs_to_many :venues
##  has_many :points

  def toppick
    @suggestions = self.suggestions
    @suggestions.each do |suggestion|
      if (@suggestion.nil?)
        @suggestion = suggestion
      else
        if (suggestion.pointcount > @suggestion.pointcount)
          @suggestion = suggestion
        end
      end
    end
    return @suggestion
  end


end
