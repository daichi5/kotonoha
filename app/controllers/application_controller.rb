class ApplicationController < ActionController::Base

  private
    def logged_in_user
      user = User.find_by(id: session[:user_id])
      unless user && session[:user_id]
        redirect_to root_path
      end
    end
end
