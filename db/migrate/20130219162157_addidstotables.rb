class Addidstotables < ActiveRecord::Migration
  def up
    add_column :suggestions, :plan_id, :integer
    add_column :suggestions, :venue_id, :integer
    add_column :invites, :user_id, :integer
    add_column :invites, :plan_id, :integer
    add_column :points, :suggestion_id, :integer
    add_column :points, :invite_id, :integer
    add_column :points, :plan_id, :integer
    add_column :microposts, :invite_id, :integer
    add_column :microposts, :plan_id, :integer

  end

  def down
  end
end
