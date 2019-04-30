require 'rails_helper'

RSpec.describe 'Phrases', type: :system, js: true do
  it 'user creates a phrase' do
    user = FactoryBot.create(:user)
    visit '/login'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'

    expect {
      click_link 'アカウント'
      click_link '新規投稿'
      fill_in '投稿内容', with: 'サンプルフレーズ' 
      fill_in '詳細', with: 'サンプル詳細'
      click_button '投稿'

      expect(page).to have_content '投稿送信完了'
      expect(page).to have_content 'サンプルフレーズ'
    }.to change(user.phrases, :count).by(1)
  end
  
  it "user edits a phrase"

  it "user deletes a phrase"
end
