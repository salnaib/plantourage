class AddPlanIdToSuggestions < ActiveRecord::Migration
  def change
    add_column :suggestions, :plan_id, :string
  end
end
