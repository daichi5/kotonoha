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
  if current_user && user.id == current_user.id
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

crumb :phrases_index do |param|
  if param
    link param, phrases_path(tag_name: param)
    parent :category
  else
    link '投稿一覧', phrases_path
  end
end

crumb :phrases_show do |phrase, referer|
  link '投稿', phrase_path(phrase)

  if referer
    uri = URI.parse(referer)
  
    if uri.path.include?('/popular')
      parent :popular
    elsif uri.path.include?('/likes')
      user = User.find(uri.path[/\A\/users\/(.*)\/likes\z/, 1])
      parent :users_show, user
    elsif uri.path.include?('/users') || uri.path.include?('/edit')
      parent :users_show, phrase.user
    elsif uri.query
      uri = Hash[URI.decode_www_form(uri.query)]
      parent :phrases_index, uri['tag_name'] if uri['tag_name']
    end
  end
end

crumb :phrases_new do |user|
  link '新規投稿'
  parent :users_show, user
end

crumb :phrases_edit do |phrase|
  link '投稿の編集'
  parent :phrases_show, phrase, '/users'
end

#sessions

crumb :sessions_new do
  link 'ログイン'
end
