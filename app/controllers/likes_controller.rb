class LikesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @liked_phrases = @user.liked_phrases
  end

  def create
    like = current_user.likes.new(phrase_id: params[:phrase_id])
    like.save 
    redirect_back(fallback_location: root_path)
  end

  def destroy
    like = current_user.likes.find_by(phrase_id: params[:phrase_id])
    like.destroy
    redirect_back(fallback_location: root_path)
  end
end
