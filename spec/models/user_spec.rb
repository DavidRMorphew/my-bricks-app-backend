require 'rails_helper'

RSpec.describe User, type: :model do
  it "requires the presence of a name" do
    expect(User.new(email: "billy@billybob.com", password: "pw")).not_to be_valid
  end
end
