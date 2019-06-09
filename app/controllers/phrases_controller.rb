class PhrasesController < ApplicationController
  before_action :login_required, only: [:new, :create, :edit]

  def index
    if params[:tag_name]
      @phrases = Phrase.set_buttons.tagged_with(params[:tag_name]).page(params[:page])
    else
      @phrases = Phrase.set_buttons.search_with(params[:q]).order(created_at: "DESC").page(params[:page])
    end
  end

  def show
    @phrase = Phrase.set_buttons.find(params[:id])
    @comment = @phrase.comments.build

    date = Date.today.strftime(format = '%Y%m%d')
    @pv = Redis.current.zscore(date, @phrase.id).to_i
    Redis.current.zincrby(date, 1, @phrase.id)
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

  def save_url_title(url)
    if @phrase&.quoted != url
      scraping_title(url)
    elsif @phrase
      @phrase.url_title
    end
  end

  def scraping_title(url)
    begin
      title = Nokogiri::HTML.parse(open(url)).title
      title.length > 30 ? ( title[0..29] + "..." ) : title
    rescue
      nil
    end
  end
end
