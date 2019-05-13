require 'rails_helper'

RSpec.describe 'Users', type: :system, js: true do
  before do
    @user = FactoryBot.create(:user, name: "testuser", email: "test@example.com")
    login_as(@user)
  end

  it 'user deletes an account' do
    expect{
      click_link 'アカウント'
      click_link 'マイページ'
      click_link '削除'
      text = page.driver.browser.switch_to.alert.text
      expect(text).to eq('アカウントを削除します。よろしいですか？')
      page.accept_confirm()
      visit '/'
      expect(User.find_by(id: @user.id)).to be_falsy
    }.to change(User, :count).by(-1)
  end

  it 'user edits a profile' do
    click_link 'アカウント'
    click_link 'マイページ'
    click_link '編集'
    fill_in '名前', with: 'updated name'
    fill_in 'メールアドレス', with: 'updated@example.com'
    fill_in '自己紹介', with: 'updated description'
    attach_file 'プロフィール画像', Rails.root + 'spec/fixtures/test_icon.jpg'
    click_button '変更を保存'
    @user.reload

    expect(@user.name).to eq('updated name')
    expect(@user.email).to eq('updated@example.com')
    expect(@user.description).to eq('updated description')
    expect(@user['image']).to eq('test_icon.jpg')

  end
end

