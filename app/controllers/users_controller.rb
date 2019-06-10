# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :login_required, only: %i[index edit update destroy]
  before_action :logout_required, only: %i[new create]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @phrases = @user.phrases.set_buttons.order('updated_at DESC').page(params[:page])
    set_chart(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'ユーザー登録が完了しました'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'プロフィール変更を保存しました。'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :description, :image)
  end

  def correct_user
    user = User.find(params[:id])
    redirect_to root_path unless user.id == current_user.id
  end
end
