# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Phrases', type: :system do
  before do
    @user = FactoryBot.create(:user, confirmed_at: Time.now)
    login_as(@user)
  end
  
  it 'user creates a phrase' do
    expect do
      visit '/'
      click_link 'アカウント'
      click_link '新規投稿', match: :first
      fill_in '投稿内容', with: 'サンプルフレーズ'
      fill_in '詳細', with: 'サンプル詳細'
      fill_in '引用元(タイトルまたはURL)', with: 'http://test.com/'
      click_button '投稿'

      expect(page).to have_content '投稿送信完了'
      expect(page).to have_content 'サンプルフレーズ'
    end.to change(@user.phrases, :count).by(1)
  end

  it 'user edits a phrase' do
    phrase = FactoryBot.create(:phrase, title: 'sample title', user: @user)

    visit '/'
    click_link 'アカウント'
    click_link 'マイページ', match: :first
    click_link 'sample title'
    click_link '編集'
    fill_in '投稿内容', with: 'title updated'
    fill_in '詳細', with: 'content updated'
    fill_in '引用元(タイトルまたはURL)', with: 'https://google.com/'
    click_button '投稿'

    expect(page).to have_content '投稿を編集しました'
    expect(page).to have_content 'title updated'
    expect(page).to have_content 'content updated'
    expect(page).to have_content 'Google(https://google.com/)'
  end

  it 'user deletes a phrase' do
    phrase = FactoryBot.create(
      :phrase,
      title: 'sample title',
      content: 'sample content',
      user: @user
    )

    expect do
      visit '/'
      click_link 'アカウント'
      click_link 'マイページ', match: :first
      click_link 'sample title'

      expect(page).to have_content('sample title')
      expect(page).to have_content('sample content')

      click_link '削除'

      expect(page).to_not have_content('sample title')
      expect(page).to_not have_content('sample content')
    end.to change(@user.phrases, :count).by(-1)
  end
end
