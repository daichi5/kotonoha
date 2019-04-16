require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with name, email, and password" do
    user = User.new(
      name: "test",
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = User.new(name: "")
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "is invalid without an email address" do
    User.create(
      name: "test",
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    )
    user = User.new(
      email: "test@example.com",
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
  
  it "is invalid with a duplicate email address"
  it "returns a user's full name as a string"
end
