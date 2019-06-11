# frozen_string_literal: true

class PhrasesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit]

  def index
    if params[:tag_name]
      @phrases = Phrase.set_buttons.tagged_with(params[:tag_name]).page(params[:page])
    else
      @phrases = Phrase.set_buttons.search_with(params[:q]).order(created_at: 'DESC').page(params[:page])
    end
  end

  def show
    @phrase = Phrase.set_buttons.find(params[:id])
    @comment = @phrase.comments.build
    @pv = access_count(@phrase)
  end

  def new
    @phrase = Phrase.new
  end

  def create
    @phrase = current_user.phrases.new(phrase_params)
    if @phrase.save
      flash[:success] = '投稿送信完了'
      redirect_to current_user
    else
      render :new
    end
  end

  def edit
    @phrase = Phrase.find(params[:id])
  end

  def update
    @phrase = Phrase.find(params[:id])
    if @phrase.update(phrase_params)
      flash[:success] = '投稿を編集しました'
      redirect_to @phrase
    else
      render :edit
    end
  end

  def destroy
    phrase = Phrase.find(params[:id])
    user = phrase.user
    phrase.destroy
    redirect_to user
  end

  private

  def phrase_params
    params[:phrase][:url_title] = save_url_title(params[:phrase][:quoted])
    params.require(:phrase).permit(:title, :content, :author, :quoted, :url_title, :tag_list)
  end

  def access_count(phrase)
    redis = Redis.current
    key = request.remote_ip.to_s + ":" + phrase.id.to_s
    date = Date.today.strftime(format = '%Y%m%d')
    unless redis.exists(key)
      ttl = 60 * 60 * 3
      redis.zincrby(date, 1, phrase.id)
      redis.set(key, true)
      redis.expire(key, ttl)
    end
    redis.zscore(date, phrase.id).to_i
  end

  def save_url_title(url)
    if @phrase&.quoted != url
      scraping_title(url)
    elsif @phrase
      @phrase.url_title
    end
  end

  def scraping_title(url)
    title = Nokogiri::HTML.parse(open(url)).title
    title.length > 30 ? (title[0..29] + '...') : title
  rescue StandardError
    nil
  end
end
