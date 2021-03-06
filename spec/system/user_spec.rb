# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system, js: true do
  let(:user) { FactoryBot.create(:user, name: 'testuser', email: 'test@example.com') }

  it 'visitor signs up' do
    visit '/users/sign_up'
    fill_in '名前', with: 'test_user'
    fill_in 'メールアドレス', with: 'test_user@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード（確認）', with: 'password'

    expect do
      click_button '登録'
    end.to change(User, :count).by(1)
  end

  it 'user edits a profile' do
    user = FactoryBot.create(:user)
    user.confirmed_at = Time.now
    user.save
    login_as(user)

    expect(user.image.attached?).to be_falsey

    visit '/'
    click_link 'アカウント'
    click_link 'マイページ', match: :first
    click_link '編集'
    fill_in '名前', with: 'updated name'
    fill_in 'メールアドレス', with: 'updated@example.com'
    fill_in '自己紹介', with: 'updated description'
    fill_in '現在のパスワード', with: 'password'
    attach_file 'プロフィール画像', Rails.root + 'spec/fixtures/test_icon.jpg'
    click_button '変更を保存'

    open_email('updated@example.com')
    current_email.click_link 'アカウントの確認'

    user.reload
    expect(user.name).to eq('updated name')
    expect(user.unconfirmed_email).to eq('updated@example.com')
    expect(user.description).to eq('updated description')
    expect(user.image.attached?).to be_truthy
  end
end
