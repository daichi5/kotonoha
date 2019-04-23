require 'rails_helper'

RSpec.describe User, type: :model do
  it "failure test" do
    expect(2).to eq(1)
  end

  it "is valid with name, email, and password" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "is valid with a name of 20 characters" do
    user = FactoryBot.build(:user, name: "a" * 20)
    expect(user).to be_valid
  end
  
  it "is invalid with a name over 20 characters" do
    user = FactoryBot.build(:user, name: "a" * 21)
    user.valid?
    expect(user.errors[:name]).to include("は20文字以内で入力してください") 
  end

  it "is invalid without email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, email: 'test@example.com')
    user = FactoryBot.build(:user, email: 'test@example.com')
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  it "is valid when a password matches a password_confirmation" do
    user = FactoryBot.build(:user, password: 'password', password_confirmation: 'password')
    expect(user).to be_valid
  end

  it "is valid when a password doesn't match a password_confirmation" do
    user = FactoryBot.build(:user, password: 'password', password_confirmation: 'passwore')
    expect(user).to_not be_valid
  end

  it "is valid with password of 6 characters" do
    user = FactoryBot.build(:user, password: "passwd", password_confirmation: "passwd")
    expect(user).to be_valid
  end

  it "is invalid with password of 5 characters" do
    user = FactoryBot.build(:user, password: "passw", password_confirmation: "passw")
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end
end
