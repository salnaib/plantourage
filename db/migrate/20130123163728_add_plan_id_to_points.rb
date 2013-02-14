class AddPlanIdToPoints < ActiveRecord::Migration
  def change
    add_column :points, :plan_id, :string
  end
end
