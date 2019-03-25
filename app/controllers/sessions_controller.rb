class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])

    if user.nil? === false && user.authenticate(params[:session][:password])
      flash[:success] = 'success!'
      session[:user_id] = user.id
      redirect_to user
    else
      flash[:danger] = 'Emailまたはパスワードが間違っています'
      render 'new'
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
