class ApplicationController < ActionController::Base
  helper_method :current_user, :liked?

  private

    #現在のユーザーを取得、sessionが無い場合はcookiesを確認
    def current_user
      if user_id = session[:user_id]
        User.find_by(id: user_id)
      
      elsif user = User.find_by(id: cookies.signed[:user_id])
        if user.authenticated?(cookies[:remember_token])
          session[:user_id] = user.id
          user
        end
      end
    end

    #自分がlikeしていればtrueを返す
    def liked?(phrase_id)
      return false unless current_user

      current_user.likes.find_by(phrase_id: phrase_id)
    end
    
    #ログインしていないユーザーをリダイレクト
    def login_required
      unless current_user
        session[:forwarding_url] = request.original_url if request.get?
        flash[:danger] = 'ログインしてください'
        redirect_to login_path 
      end
    end
    
    #ログインしているユーザーをリダイレクト
    def logout_required
      if user = current_user
        redirect_to user
      end
    end

end
