class StaticPagesController < ApplicationController
  def home
    phrase_id = Like.group(:phrase_id).order(count_all: "DESC").count.first[0]
    @phrase = Phrase.find(phrase_id)
    @phrases = Phrase.order(created_at: "DESC").page(params[:page])
  end

  def about
  end

  def help
  end

  def test_login
    if !session[:user_id]
      session[:user_id] = 1
    end
    redirect_to root_path
  end
end
