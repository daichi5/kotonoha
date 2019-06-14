# frozen_string_literal: true

class PhrasesController < ApplicationController
  helper_method :modified_url
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
    @pv = @phrase.access_count(request.remote_ip)
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
    params[:phrase][:url_title] = @phrase.save_url_title(params[:phrase][:quoted])
    params.require(:phrase).permit(:title, :content, :author, :quoted, :url_title, :tag_list)
  end

  #view helper

  def modified_url(phrase)
    url = phrase.quoted
    if phrase.url_title.present? && url.length > 30
      url[0..29] + "..."
    else
      url
    end
  end
end
