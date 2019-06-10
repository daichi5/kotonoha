# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Phrase, type: :model do
  let(:phrase) { FactoryBot.build(:phrase) }

  it 'is valid with title, content, url' do
    expect(phrase).to be_valid
  end

  it 'is invalid without a title' do
    phrase.title = nil
    phrase.valid?
    expect(phrase.errors['title']).to include('を入力してください')
  end

  it 'is valid with a title of 150characters' do
    phrase.title = 'a' * 150
    expect(phrase).to be_valid
  end

  it 'is invalid with a title over 150 characters' do
    phrase.title = 'a' * 151
    phrase.valid?
    expect(phrase.errors['title']).to include('は150文字以内で入力してください')
  end

  it 'is valid with a content of 200characters' do
    phrase.content = 'a' * 200
    expect(phrase).to be_valid
  end

  it 'is invalid with a content over 200 characters' do
    phrase.content = 'a' * 201
    phrase.valid?
    expect(phrase.errors['content']).to include('は200文字以内で入力してください')
  end

  it 'is valid with a author of 50characters' do
    phrase.author = 'a' * 50
    expect(phrase).to be_valid
  end

  it 'is invalid with a author over 50 characters' do
    phrase.author = 'a' * 51
    phrase.valid?
    expect(phrase.errors['author']).to include('は50文字以内で入力してください')
  end

  it 'is valid with a quoted of 800characters' do
    phrase.quoted = 'a' * 800
    expect(phrase).to be_valid
  end

  it 'is invalid with a quoted over 800 characters' do
    phrase.quoted = 'a' * 801
    phrase.valid?
    expect(phrase.errors['quoted']).to include('は800文字以内で入力してください')
  end

  it 'is invalid without a user' do
    phrase.user = nil
    expect(phrase).to_not be_valid
  end

  it 'is invalid with an invalid user id' do
    phrase.user_id = -1
    expect(phrase).to_not be_valid
  end

  it 'is deleted when parent user id deleted' do
    phrase.save
    user = User.find(phrase.user_id)
    user.destroy
    expect(Phrase.find_by(id: phrase.id)).to be_falsy
  end
end
