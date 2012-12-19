require 'spec_helper'

describe "venues/new" do
  before(:each) do
    assign(:venue, stub_model(Venue,
      :name => "MyString",
      :website => "MyString",
      :address => "MyText",
      :image => "MyString"
    ).as_new_record)
  end

  it "renders new venue form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => venues_path, :method => "post" do
      assert_select "input#venue_name", :name => "venue[name]"
      assert_select "input#venue_website", :name => "venue[website]"
      assert_select "textarea#venue_address", :name => "venue[address]"
      assert_select "input#venue_image", :name => "venue[image]"
    end
  end
end
