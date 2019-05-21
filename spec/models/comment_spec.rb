require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.build(:comment) }

  it "is valid with name, content" do
    expect(comment).to be_valid
  end

  it "is invalid without a name" do
    comment.name = nil
    expect(comment).to_not be_valid
  end

  it "is invalid without a content" do
    comment.content = nil
    expect(comment).to_not be_valid
  end
end
