require 'rails_helper'

RSpec.describe 'SignUp', type: :system do
  it 'user sign_up' do
    visit '/signup'
    fill_in '名前', with: 'test_user'
    fill_in 'メールアドレス', with: 'test_user@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認）', with: 'password'

    expect {
      click_button '登録'
    }.to change(User, :count).by(1)
    expect(page).to have_content '登録が完了しました'
  end

end
