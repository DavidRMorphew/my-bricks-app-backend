require 'rails_helper'

RSpec.describe User, type: :model do
  it "requires the presence of a name" do
    expect(User.new(email: "billy@billybob.com", password: "pw")).not_to be_valid
  end

  it "requires the presence of a password" do
    expect(User.new(name: "Bill", email: "billy@billybob.com")).not_to be_valid
  end

  it "requires the presence of an email address" do
    expect(User.new(name: "Billy", password: "pw")).not_to be_valid
  end
end
