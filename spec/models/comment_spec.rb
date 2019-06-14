# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.build(:comment) }

  it 'is valid with name, content' do
    expect(comment).to be_valid
  end

  it 'is invalid without a name' do
    comment.name = nil
    comment.valid?
    expect(comment.errors['name']).to include('を入力してください')
  end

  it 'is invalid without a content' do
    comment.content = nil
    comment.valid?
    expect(comment.errors['content']).to include('を入力してください')
  end

  it 'is valid with a name of 30 characters' do
    comment.name = 'a' * 30
    expect(comment).to be_valid
  end

  it 'is invalid with a name over 30 characters' do
    comment.name = 'a' * 31
    comment.valid?
    expect(comment.errors['name']).to include('は30文字以内で入力してください')
  end

  it 'is valid with a content of 200 characters' do
    comment.content = 'a' * 200
    expect(comment).to be_valid
  end

  it 'is invalid with a content over 200 characters' do
    comment.content = 'a' * 201
    comment.valid?
    expect(comment.errors['content']).to include('は200文字以内で入力してください')
  end

  it 'is deleted when parent phase is deleted' do
    comment.save
    phrase = Phrase.find(comment.phrase_id)
    phrase.destroy
    expect(Comment.find_by(id: comment.id)).to be_falsy
  end

  it 'is deleted when parent user is deleted' do
    comment.save
    phrase = Phrase.find(comment.phrase_id)
    user = User.find(phrase.user_id)
    user.destroy
    expect(Comment.find_by(id: comment.id)).to be_falsy
  end
end
