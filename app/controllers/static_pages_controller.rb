class StaticPagesController < ApplicationController
  def home
    @user = User.all
  end

  def about
  end

  def help
  end
end
