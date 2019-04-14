require 'rails_helper'

describe 'User', type: :system do
  describe 'user signup' do
    before do
      visit signup_path
      fill_in 'Name', with: 'test_user'
      fill_in 'Email', with: 'test_user@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Confirmation', with: 'password'
      click_button '登録'
    end

    it 'success' do
      expect(page).to have_content '登録を受け付けました'
    end
  end
end
