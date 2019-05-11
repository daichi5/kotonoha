require 'rails_helper'

RSpec.describe 'Users', type: :system, js: true do
  it 'user deletes an account' do
    user = FactoryBot.create(:user, name: "testuser", email: "test@example.com")
    login_as(user)

    expect{
      click_link 'アカウント'
      click_link 'マイページ'
      click_link '削除'
      text = page.driver.browser.switch_to.alert.text
      expect(text).to eq('アカウントを削除します。よろしいですか？')
      page.accept_confirm()
      visit '/'
      expect(User.find_by(id: user.id)).to be_falsy
    }.to change(User, :count).by(-1)
  end
end
