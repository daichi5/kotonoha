require 'rails_helper'

RSpec.describe 'Comments', type: :system, js: true do
  it 'visitor creates a comment' do
    phrase = FactoryBot.create(:phrase)
    
    expect {
      visit "/phrases/#{phrase.id}"
      fill_in "名前", with: "sample name"
      fill_in "コメント", with: "sample comment"
      click_button "投稿"
      expect(page).to have_content("sample name")
      expect(page).to have_content("sample comment")
    }.to change(phrase.comments, :count).by(1)

  end
end
