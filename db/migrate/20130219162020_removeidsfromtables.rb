class Removeidsfromtables < ActiveRecord::Migration
  def up
    remove_column :suggestions, :plan_id
    remove_column :suggestions, :venue_id
    remove_column :invites, :user_id
    remove_column :invites, :plan_id
    remove_column :points, :suggestion_id
    remove_column :points, :invite_id
    remove_column :points, :plan_id
    remove_column :microposts, :invite_id
    remove_column :microposts, :plan_id

  end

  def down
  end
end
