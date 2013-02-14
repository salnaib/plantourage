class AddPlanIdToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :plan_id, :string
  end
end
