# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :system, js: true do
  it 'visitor creates a comment' do
    user = FactoryBot.create(:user)
    phrase = FactoryBot.create(:phrase, user: user)

    expect do
      visit "/phrases/#{phrase.id}"
      fill_in '名前', with: 'sample name'
      fill_in 'コメント', with: 'sample comment'
      click_button '投稿'
      expect(page).to have_content('sample name')
      expect(page).to have_content('sample comment')
    end.to change(phrase.comments, :count).by(1)
  end
end
