class Invite < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user
  belongs_to :plan
  has_many :points
  has_many :microposts

  def self.find_by_facebookid_and_plan_id(fbid, planid)

    @user = User.find_by_uid(fbid)
    if @user.nil?
      return nil
    else
      @invite = Invite.find_by_user_id_and_plan_id(@user.id, planid)
      return @invite

    end

  end


end
