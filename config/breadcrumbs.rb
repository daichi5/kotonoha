crumb :root do
  link "Home", root_path
end

#static_pages

crumb :category do
  link 'カテゴリ', category_path
end

crumb :popular do
  link '人気の投稿', popular_path
end

crumb :about do
  link 'ガイド', about_path
end

crumb :contact do
  link '運営情報', contact_path
end

#users

crumb :users_show do |user|
  if user.id == current_user.id
    link 'マイページ', user_path(user)
  else
    link user.name , user_path(user)
    parent :users_index
  end
end

crumb :users_index do
  link 'ユーザーリスト', users_path
end

crumb :users_new do
  link '新規登録'
end

crumb :users_edit do | user|
  link 'プロフィール編集'
  parent :users_show, user
end

#phrases

crumb :phrases_index do
  link '投稿一覧', phrases_path
end

crumb :phrases_show do |phrase|
  link '投稿', phrase_path(phrase)
  parent :users_show, phrase.user
end

crumb :phrases_new do |user|
  link '新規投稿'
  parent :users_show, user
end

crumb :phrases_edit do |phrase|
  link '投稿の編集'
  parent :phrases_show, phrase
end

#sessions

crumb :sessions_new do
  link 'ログイン'
end
