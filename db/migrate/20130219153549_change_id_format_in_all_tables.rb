class ChangeIdFormatInAllTables < ActiveRecord::Migration
  def up
    change_column :suggestions, :plan_id, :integer
    change_column :suggestions, :venue_id, :integer
    change_column :invites, :user_id, :integer
    change_column :invites, :plan_id, :integer
    change_column :points, :suggestion_id, :integer
    change_column :points, :invite_id, :integer
    change_column :points, :plan_id, :integer
    change_column :microposts, :invite_id, :integer
    change_column :microposts, :plan_id, :integer

  end

  def down
    change_column :suggestions, :plan_id, :string
    change_column :suggestions, :venue_id, :string
    change_column :invites, :user_id, :string
    change_column :invites, :plan_id, :string
    change_column :points, :suggestion_id, :string
    change_column :points, :invite_id, :string
    change_column :points, :plan_id, :string
    change_column :microposts, :invite_id, :string
    change_column :microposts, :plan_id, :string

  end
end
