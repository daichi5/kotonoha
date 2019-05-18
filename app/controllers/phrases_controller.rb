class PhrasesController < ApplicationController
  before_action :login_required, only: [:new, :create, :edit]

  def index
    query = { title_or_content_cont: params[:q] }
    q = Phrase.ransack(query)
    @phrases = q.result(distinct: true)
  end

  def show
    @phrase = Phrase.find(params[:id])
    @comment = @phrase.comments.build
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
    params.require(:phrase).permit(:title, :content, :quoted, :url_title)
  end

  def save_url_title(url)
    begin
      doc = Nokogiri::HTML.parse(open(url))
      title = doc.title
      if title.length > 30
        title[0..29] + "..."
      else
        title
      end
    rescue
      nil
    end
  end
end
