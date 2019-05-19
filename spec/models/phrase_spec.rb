require 'rails_helper'

RSpec.describe Phrase, type: :model do
  it "is valid with title, description, url" do
    phrase = FactoryBot.build(:phrase)
    expect(phrase).to be_valid
  end

  it "is invalid without a title" do
    phrase = FactoryBot.build(:phrase, title: nil)
    expect(phrase).to_not be_valid
  end

  it "is invalid without a user" do
    phrase = FactoryBot.build(:phrase, user: nil)
    expect(phrase).to_not be_valid
  end

  it "is invalid with an invalid user id" do
    phrase = FactoryBot.build(:phrase, user_id: -1 )
    expect(phrase).to_not be_valid
  end
end
