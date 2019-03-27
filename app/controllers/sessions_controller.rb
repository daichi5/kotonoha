class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])

    if user.nil? === false && user.authenticate(params[:session][:password])
      #永続セッション保持
      if (params[:session][:remember_me] == '1') 
        remember(user)
        flash[:danger] = params[:session][:remember_me] 
      end 
      #flash[:success] = 'success!'
      session[:user_id] = user.id

      #friendly forwarding
      redirect_to (session[:forwarding_url] ? session[:forwarding_url] : user ) 
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

end
