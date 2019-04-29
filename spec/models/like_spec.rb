require 'rails_helper'

RSpec.describe Like, type: :model do

  it "is valid with user, phrase" do
    like = FactoryBot.build(:like)
    expect(like).to be_valid
  end

  it "is invalid without user" do
    like = FactoryBot.build(:like, user: nil)
    expect(like).to_not be_valid
  end

  it "is invalid with invalid user id" do
    like = FactoryBot.build(:like, user_id: -1)
    expect(like).to_not be_valid
  end

  it "is invalid without phrase" do
    like = FactoryBot.build(:like, phrase: nil)
    expect(like).to_not be_valid
  end

  it "is invalid with invalid phrase id" do
    like = FactoryBot.build(:like, phrase_id: -1)
    expect(like).to_not be_valid
  end
end
