module SessionsHelper

  def logged_in?
    
    if user_id = session[:user_id]
      current_user = User.find_by(id: user_id)
    end
  end

end
