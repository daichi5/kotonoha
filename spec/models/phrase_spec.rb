require 'rails_helper'

RSpec.describe Phrase, type: :model do
  let(:phrase) { FactoryBot.build(:phrase) }

  it "is valid with title, description, url" do
    expect(phrase).to be_valid
  end

  it "is invalid without a title" do
    phrase.title = nil
    expect(phrase).to_not be_valid
  end

  it "is invalid without a user" do
    phrase.user = nil
    expect(phrase).to_not be_valid
  end

  it "is invalid with an invalid user id" do
    phrase.user_id = -1
    expect(phrase).to_not be_valid
  end
end
