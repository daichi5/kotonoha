class ApplicationController < ActionController::Base

  include SessionsHelper

  private
    #ログインしていないユーザーをリダイレクト
    def logged_in_user
      if !logged_in?
        flash[:danger] = 'ログインしてください'
        redirect_to login_path 
      end
    end
end
