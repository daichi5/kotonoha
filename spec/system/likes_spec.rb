# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes', type: :system, js: true do
  before do
    @user = FactoryBot.create(:user, confirmed_at: Time.now)
    @phrase = FactoryBot.create(:phrase)
    login_as(@user)
  end

  it 'user creates a like' do
    visit "/phrases/#{@phrase.id}"

    expect do
      expect(page).to have_css('.far.fa-heart')
      expect(page).to_not have_css('.fas.fa-heart')

      find('i.fa-heart').click

      expect(page).to_not have_css('.far.fa-heart')
      expect(page).to have_css('.fas.fa-heart')
    end.to change(@phrase.likes, :count).by(1)
  end

  it 'user deletes a like' do
    like = FactoryBot.create(:like, user: @user, phrase: @phrase)
    visit "/phrases/#{@phrase.id}"

    expect do
      expect(page).to_not have_css('.far.fa-heart')
      expect(page).to have_css('.fas.fa-heart')

      find('i.fa-heart').click

      expect(page).to have_css('.far.fa-heart')
      expect(page).to_not have_css('.fas.fa-heart')
    end.to change(@phrase.likes, :count).by(-1)
  end
end
