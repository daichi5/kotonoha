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

  def popular
    @phrases = Phrase.joins(:likes).group(:id).order('count(likes.id) desc').page(1)
  end

  def category
    @tags = Phrase.tag_counts.order(taggings_count: "DESC")
  end

  def test_login
    if !session[:user_id]
      session[:user_id] = 1
    end
    redirect_to user_path(1)
  end
end
