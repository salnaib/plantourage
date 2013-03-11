class Modifyvenueformapinfo < ActiveRecord::Migration
  def up
    add_column :venues, :google_id, :string
    add_column :venues, :city, :string
    add_column :venues, :state, :string
    add_column :venues, :country, :string
    add_column :venues, :postal, :string
    add_column :venues, :phone, :string
    add_column :venues, :googleurl, :string
    add_column :venues, :geolocation, :string
    add_column :venues, :type, :string
  end

  def down
  end
end
