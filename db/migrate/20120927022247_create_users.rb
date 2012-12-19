class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :fbid

      t.timestamps
    end
  end
end
