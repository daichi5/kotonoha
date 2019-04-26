require 'rails_helper'

RSpec.describe 'Phrase', type: :system, js: true do
  it 'user create a phrase' do
    user = FactoryBot.create(:user)
    login_by_capybara(user)

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

end
