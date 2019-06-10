# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @phrase = Phrase.find(params[:phrase_id])
    @comment = @phrase.comments.new(comment_params)
    if @comment.save
      render :comment_create
    else
      render :comment_errors
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :content)
  end
end
