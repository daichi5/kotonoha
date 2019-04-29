require 'rails_helper'

RSpec.describe 'SignUp', type: :system do
  it 'user sign_up' do
    visit '/signup'
    fill_in User.human_attribute_name(:name), with: 'test_user'
    fill_in User.human_attribute_name(:email), with: 'test_user@example.com'
    fill_in User.human_attribute_name(:password), with: 'password'
    fill_in User.human_attribute_name(:password_confirmation), with: 'password'

    expect {
      click_button '登録'
    }.to change(User, :count).by(1)
    expect(page).to have_content '登録が完了しました'
  end

end
