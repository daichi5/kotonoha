class PhrasesController < ApplicationController
  before_action :login_required, only: [:new, :create, :edit]

  def index
  end

  def show
    @phrase = Phrase.find(params[:id])
    @comment = @phrase.comments.build
  end

  def new
    @phrase = current_user.phrases.new
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
  end

  def update
  end

  def destroy
    phrase = Phrase.find(params[:id])
    user = phrase.user

    phrase.destroy
    redirect_to user
  end

  private
  def phrase_params
    params.require(:phrase).permit(:title, :content)
  end
end
