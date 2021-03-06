# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :login_alert, only: %i[create destroy]

  def show
    @user = User.find(params[:user_id])
    @liked_phrases = @user.liked_phrases.set_buttons.order(created_at: 'DESC').page(params[:page])
    set_chart(@user)
  end

  def create
    @like = current_user.likes.new(phrase_id: params[:phrase_id])
    @like.save
  end

  def destroy
    @like = current_user.likes.find_by(phrase_id: params[:phrase_id])
    @like.destroy
  end

  private

  def login_alert
    render 'login_alert' unless current_user
  end
end
