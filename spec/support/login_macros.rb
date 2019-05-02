module LoginMacros
  #単体テスト用ログインメソッド
  def login(user)
    session[:user_id] = user.id
  end

  def login_as(user)
    visit '/login'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end
end
