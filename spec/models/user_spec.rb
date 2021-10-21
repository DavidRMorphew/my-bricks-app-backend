require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user1_downcase) {
    User.create(
      name: "Bob",
      email: "bobman@bobby.com",
      password: "pw"
    )
  }
  
  let(:user1_downcase_duplicate) {
    User.new(
      name: "Bob",
      email: "bobman@bobby.com",
      password: "pw"
    )
  }

  let(:user1_uppercase) {
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
    expect(user1_downcase).to be_valid
    expect(user1_downcase_duplicate).not_to be_valid
  end

  it "requires that each email be unique and case-insensitive" do
    expect(user1_downcase).to be_valid
    expect(user1_uppercase).not_to be_valid
  end
end
