class StaticPagesController < ApplicationController
  def home
    @user = User.all
    @phrases = Phrase.all
  end

  def about
  end

  def help
  end
end
