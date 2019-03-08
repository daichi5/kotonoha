class UsersController < ApplicationController
  def new
    @user = User.new();
  end

  def create
    @user = User.new(user_params);

    if @user.save

    else
      redirect_to root_path
    end
  end

  def edit
  end

  def update
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
