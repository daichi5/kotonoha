# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @user = User.new
    date = Date.today.strftime(format = '%Y%m%d')
    popular_id = Redis.current.zrevrangebyscore(date, '+inf', '-inf').first 
    @phrase = Phrase.set_buttons.find_by(id: popular_id)
    @phrases = Phrase.set_buttons.order(created_at: "DESC").page(params[:page])
  end

  def about; end

  def help; end

  def popular
    @phrases = Phrase.set_buttons.order(likes_count: 'DESC').page(params[:page])
  end

  def category
    @tags = Phrase.tag_counts.order(taggings_count: 'DESC')
  end

end
