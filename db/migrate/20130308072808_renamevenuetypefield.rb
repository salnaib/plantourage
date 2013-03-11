class Renamevenuetypefield < ActiveRecord::Migration
  def change
    rename_column :venues, :type, :venue_type
  end
end
