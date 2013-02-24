class Addmissingvenues < ActiveRecord::Migration
  def up
    Venue.create(:name => 'Brant House', :website => 'http://www.clubzone.com/c/8798/brant-house-toronto', :address => '522 King St. W, Toronto, ON', :image => 'http://images3-cdn.clubzone.com/company/images/8798t.jpg')
    Venue.create(:name => 'Spice Route', :website => 'http://www.clubzone.com/c/18155/spice-route-toronto', :address => '499 King Street West, Toronto, ON', :image => 'http://images4-cdn.clubzone.com/company/images/18155t.jpg')
  end

  def down
  end
end
