module LoginMacros
  #単体テスト用ログインメソッド
  def login(user)
    session[:user_id] = user.id
  end
end
