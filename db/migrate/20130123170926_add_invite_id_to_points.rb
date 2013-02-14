class AddInviteIdToPoints < ActiveRecord::Migration
  def change
    add_column :points, :invite_id, :string
  end
end
