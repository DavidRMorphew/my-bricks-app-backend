require 'rails_helper'

RSpec.describe OwnedSet, type: :model do
  
  let(:user) {
    User.create(
      name: "Bob",
      email: "bobman@bobby.com",
      password: "pw"
    )
  }

  let(:space_theme){
    Theme.create(
      theme_number: "1",
      name: "space"
    )
  }

  let(:city_theme) {
    Theme.create(
      theme_number: "2",
      name: "city"
    )
  }


  let(:lunar_launch_lego_set) {
    LegoSet.create(
      theme_id: space_theme.id,
      set_number: "6959—1",
      name: "Lunar Launch Site",
      image_url: "https://cdn.rebrickable.com/media/sets/6959-1/13008.jpg",
      year: 1994,
      instructions_url: "https://rebrickable.com/instructions/6959-1",
      total_bricks: 288
    )
  }

  let(:fuel_truck_lego_set) {
    LegoSet.create(
      theme_id: city_theme.id,
      set_number: "6459—1",
      image_url: "https://cdn.rebrickable.com/media/sets/6459-1/2807.jpg",
      year: 1999,
      instructions_url: "https://rebrickable.com/instructions/6459-1",
      total_bricks: 120
    )
  }
  
  let(:owned_set) {
    OwnedSet.create(
      user: user, 
      lego_set: lunar_launch_lego_set
    )
  }

  let(:owned_set_duplicate) {
    OwnedSet.new(
      user: user, 
      lego_set: lunar_launch_lego_set
    )
  }
  
  it "requires that each owned set entry have a user" do
    expect(OwnedSet.new(lego_set_id: 1)).not_to be_valid
  end

  it "requires that each owned set entry have a lego set" do
    expect(OwnedSet.new(user_id: 1)).not_to be_valid
  end

  it "requires that the user own only one of a set" do
    expect(owned_set).to be_valid
    expect(owned_set_duplicate).not_to be_valid
  end
end
