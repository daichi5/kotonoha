require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { FactoryBot.build(:like) }

  it "is valid with user, phrase" do
    expect(like).to be_valid
  end

  it "is invalid without user" do
    like.user = nil
    expect(like).to_not be_valid
  end

  it "is invalid with invalid user id" do
    like.user_id = -1
    expect(like).to_not be_valid
  end

  it "is invalid without phrase" do
    like.phrase = nil
    expect(like).to_not be_valid
  end

  it "is invalid with invalid phrase id" do
    like.phrase_id = -1
    expect(like).to_not be_valid
  end

  it "is invalid when duplicated record exists" do
    dup_like = FactoryBot.create(:like)
    like.user_id = dup_like.user_id
    like.phrase_id = dup_like.phrase_id
    like.valid?
    expect(like.errors["user_id"]).to include('は既にいいねしています')
  end
end
