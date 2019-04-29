require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "is valid with name, content" do
    comment = FactoryBot.build(:comment)
    expect(comment).to be_valid
  end

  it "is invalid without a name" do
    comment = FactoryBot.build(:comment, name: nil)
    expect(comment).to_not be_valid
  end

  it "is invalid without a content" do
    comment = FactoryBot.build(:comment, content: nil)
    expect(comment).to_not be_valid
  end
end
