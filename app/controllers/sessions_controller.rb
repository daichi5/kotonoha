class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user && user.authenticate(session_params[:password])
      #永続セッション保持
      if (session_params[:remember_me] == '1') 
        remember(user)
      end 
      flash[:success] = "success!!#{cookies.signed[:user_id].inspect}"
      session[:user_id] = user.id

      #friendly forwarding
      redirect_to ( session[:forwarding_url] || user ) 
      session.delete(:forwarding_url)
    else
      flash[:danger] = 'Emailまたはパスワードが間違っています'
      render 'new'
    end
  end


  def destroy
    log_out
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :remember_me)
  end

  def log_out
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    session.delete(:user_id)
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end


end