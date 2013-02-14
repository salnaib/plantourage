class RemoveColumns < ActiveRecord::Migration
  def up
    remove_column :points, :user_id
    remove_column :points, :venue_id
  end

  def down
    add_column :points, :user_id, :string
    add_column :points, :venue_id, :string
  end
end
