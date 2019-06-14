# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  it 'is valid with name, email, and password' do
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user.name = nil
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
  end

  it 'is valid with a name of 20 characters' do
    user.name = 'a' * 20
    expect(user).to be_valid
  end

  it 'is invalid with a name over 20 characters' do
    user.name = 'a' * 21
    user.valid?
    expect(user.errors[:name]).to include('は20文字以内で入力してください')
  end

  it 'is invalid without email' do
    user.email = nil
    user.valid?
    expect(user.errors[:email]).to include('を入力してください')
  end

  it 'is invalid with a duplicate email address' do
    FactoryBot.create(:user, email: 'test@example.com')
    user.email = 'test@example.com'
    user.valid?
    expect(user.errors[:email]).to include('はすでに存在します')
  end

  it 'is valid when a password matches a password_confirmation' do
    user.password = 'password'
    user.password_confirmation = 'password'
    expect(user).to be_valid
  end

  it "is valid when a password doesn't match a password_confirmation" do
    user.password = 'password'
    user.password_confirmation = 'passwore'
    expect(user).to_not be_valid
  end

  it 'is valid with password of 6 characters' do
    user.password = 'passwd'
    user.password_confirmation = 'passwd'
    expect(user).to be_valid
  end

  it 'is invalid with password of 5 characters' do
    user.password = 'passw'
    user.password_confirmation = 'passw'
    user.valid?
    expect(user.errors[:password]).to include('は6文字以上で入力してください')
  end

  it 'is valid with a description 120 characters ' do
    user.description = 'a' * 120
    expect(user).to be_valid
  end

  it 'is invalid with a description over 120 characters ' do
    user.description = 'a' * 121
    user.valid?
    expect(user.errors[:description]).to include('は120文字以内で入力してください')
  end
end
