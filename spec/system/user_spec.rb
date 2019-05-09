require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    @user = FactoryBot.create(:user, name: "testuser", email: "test@example.com")
    login_as(@user)
  end

  it 'user edits a profile'


  it 'user deletes an account', js: true do
    visit "/users/#{user.id}"
    expect{
      click_button '削除'
      click_button 'OK'
    }.to change(User, :count).by(-1)

    expect(response).to redirect_to('/');
  end
end
