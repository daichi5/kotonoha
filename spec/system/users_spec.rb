require 'rails_helper'

describe 'User', type: :system do
  describe 'user signup' do
    before do
      visit signup_path
      fill_in User.human_attribute_name(:name), with: 'test_user'
      fill_in User.human_attribute_name(:email), with: 'test_user@example.com'
      fill_in User.human_attribute_name(:password), with: 'password'
      fill_in User.human_attribute_name(:password_confirmation), with: 'password'
    end

    it 'should success' do
      user_count = User.all.count
      expect {
        click_button '登録'
        user_count = User.all.count
      }.to change { user_count }

      expect(page).to have_content '登録を受け付けました'
    end

    it 'should failure with invalid name' do
      fill_in User.human_attribute_name(:name), with: ''
      click_button '登録'

      expect(page).not_to have_content '登録を受け付けました'
      expect(page).to have_css('.alert')
    end


  end
end
