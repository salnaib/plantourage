class Micropost < ActiveRecord::Base
  attr_accessible :content, :plan_id, :invite_id

  belongs_to :invite

  default_scope order: 'microposts.created_at DESC'
end
