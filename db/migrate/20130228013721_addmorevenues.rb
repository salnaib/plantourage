class Addmorevenues < ActiveRecord::Migration
  def up
    Venue.create(:name => 'Ivy Bar', :website => 'http://www.ivybar.ca/', :address => '3330 South Service Road, Burlington, ON', :image => 'http://www.ivybar.ca/images/ivy_logo.gif')
    Venue.create(:name => 'Buonanotte', :website => 'http://www.buonanotte.com/toronto.html', :address => '19 Mercer Street, Toronto, ON', :image => 'http://www.buonanotte.com/images/comingsoon.jpg')
  end

  def down
  end
end
