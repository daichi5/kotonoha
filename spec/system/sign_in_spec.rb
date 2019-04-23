require 'rails_helper'

RSpec.describe 'SignUp', type: :system do  
  it "user sign_in" do
    user = FactoryBot.create(:user)

    visit login_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect(page).to have_content "ログインしました"
  end

end