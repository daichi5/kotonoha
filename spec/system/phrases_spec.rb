require 'rails_helper'

RSpec.describe 'Phrases', type: :system do
  it 'user creates a phrase' do
    user = FactoryBot.create(:user)
    login_as(user)

    expect {
      click_link 'アカウント'
      click_link '新規投稿'
      fill_in '投稿内容', with: 'サンプルフレーズ' 
      fill_in '詳細', with: 'サンプル詳細'
      fill_in '引用元(タイトルまたはURL)', with: 'http://test.com/'
      click_button '投稿'

      expect(page).to have_content '投稿送信完了'
      expect(page).to have_content 'サンプルフレーズ'
    }.to change(user.phrases, :count).by(1)
  end
  
  it "user edits a phrase" do
    user = FactoryBot.create(:user)
    phrase = FactoryBot.create(:phrase, title: 'sample title', user: user)
    login_as(user)

    click_link 'アカウント'
    click_link 'マイページ'
    click_link 'sample title'
    click_link '編集'
    fill_in '投稿内容', with: 'title updated'
    fill_in '詳細', with: 'content updated'
    fill_in '引用元(タイトルまたはURL)', with: 'https://google.com/'
    click_button '保存'

    expect(page).to have_content '投稿を編集しました'
    expect(page).to have_content 'title updated'
    expect(page).to have_content 'content updated'
    expect(page).to have_content 'Google(https://google.com/)'
  end

  it "user deletes a phrase" do
    user = FactoryBot.create(:user)
    phrase = FactoryBot.create(
      :phrase,
      title: 'sample title',
      content: 'sample content',
      user: user
    )
    login_as(user)

    expect{
      click_link 'アカウント'
      click_link 'マイページ'
      click_link 'sample title'

      expect(page).to have_content('sample title')
      expect(page).to have_content('sample content')

      click_link '削除'

      expect(page).to_not have_content('sample title')
      expect(page).to_not have_content('sample content')
    }.to change(user.phrases, :count).by(-1)
    
  end
end
