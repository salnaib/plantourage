class AddVenueIdToPoints < ActiveRecord::Migration
  def change
    add_column :points, :venue_id, :string
  end
end
