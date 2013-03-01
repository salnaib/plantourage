class AddFbEventIdToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :fbevent_id, :string
  end
end
