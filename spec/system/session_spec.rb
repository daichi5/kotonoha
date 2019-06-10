# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SignIn', type: :system, js: true do
  let(:user) { FactoryBot.create(:user) }

  it 'user signs in' do
    visit '/login'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
  end

  it 'user signs out' do
    FactoryBot.create(:like)
    login_as(user)
    visit '/'
    click_link 'アカウント'
    click_link 'ログアウト'

    expect(page).to_not have_content('アカウント')
    expect(page).to have_content('はじめる')
  end
end
