class AddUserIdToPoints < ActiveRecord::Migration
  def change
    add_column :points, :user_id, :string
  end
end
