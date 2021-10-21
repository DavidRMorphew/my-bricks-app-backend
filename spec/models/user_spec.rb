require 'rails_helper'

RSpec.describe User, type: :model do
  
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
  
  let(:user_downcase_duplicate) {
    User.new(
      name: "Bob",
      email: "bobman@bobby.com",
      password: "pw"
    )
  }

  let(:user_uppercase) {
    User.new(
      name: "Bob",
      email: "BOBMAN@bobby.com",
      password: "pw"
    )
  }


  it "requires the presence of a name" do
    expect(User.new(email: "billy@billybob.com", password: "pw")).not_to be_valid
  end

  it "requires the presence of a password" do
    expect(User.new(name: "Bill", email: "billy@billybob.com")).not_to be_valid
  end

  it "requires the presence of an email address" do
    expect(User.new(name: "Billy", password: "pw")).not_to be_valid
  end

  it "requires that each email be unique" do
    expect(user).to be_valid
    expect(user_downcase_duplicate).not_to be_valid
  end

  it "requires that each email be unique and case-insensitive" do
    expect(user).to be_valid
    expect(user_uppercase).not_to be_valid
  end

  it "has many owned_sets" do
    first_owned_set = OwnedSet.create(user_id: user.id, lego_set_id: lunar_launch_lego_set.id)
    second_owned_set = OwnedSet.create(user_id: user.id, lego_set_id: fuel_truck_lego_set.id)
    expect(user.owned_sets.first).to eq(first_owned_set)
    expect(user.owned_sets.last).to eq(second_owned_set)
  end
end
