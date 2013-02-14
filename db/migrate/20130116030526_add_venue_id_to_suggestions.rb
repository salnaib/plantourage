class AddVenueIdToSuggestions < ActiveRecord::Migration
  def change
    add_column :suggestions, :venue_id, :string
  end
end
