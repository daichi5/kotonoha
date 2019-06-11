# frozen_string_literal: true

class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @phrases = @user.phrases.set_buttons.order('updated_at DESC').page(params[:page])
    set_chart(@user)
  end

end
