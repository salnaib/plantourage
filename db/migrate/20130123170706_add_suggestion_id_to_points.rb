class AddSuggestionIdToPoints < ActiveRecord::Migration
  def change
    add_column :points, :suggestion_id, :string
  end
end
