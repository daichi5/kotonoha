class ApplicationController < ActionController::Base

  include SessionsHelper

  private
    #ログインしていないユーザーをリダイレクト
    def logged_in_user
      if !logged_in?
        #friednly forwarding
        session[:forwarding_url] = request.original_url if request.get?

        flash[:danger] = 'ログインしてください'
        redirect_to login_path 
      end
    end
end
