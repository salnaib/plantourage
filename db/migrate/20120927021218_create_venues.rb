class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :website
      t.text :address
      t.string :image

      t.timestamps
    end
  end
end
