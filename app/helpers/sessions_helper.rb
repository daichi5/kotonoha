module SessionsHelper

  #ログインしていればtrueを返す
  def logged_in?
    if ( user_id = session[:user_id] ) 
      user = User.find_by(id: user_id) 
    elsif ( user_id = cookies.signed[:user_id] ) 
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        #sessionにuser_idを格納
        session[:user_id] = user.id
      end
    else
      return false
    end
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def log_out
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    session.delete(:user_id)
  end
end
