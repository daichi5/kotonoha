class StaticPagesController < ApplicationController
  def home
    @user = User.all
    @phrases = Phrase.order(created_at: "DESC").page(params[:page])
  end

  def about
  end

  def help
  end
end
