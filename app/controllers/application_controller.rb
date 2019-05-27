class ApplicationController < ActionController::Base
  helper_method :current_user, :liked?

  private
  
  def current_user
    if user_id = session[:user_id]
      User.find_by(id: user_id)
    elsif user = User.find_by(id: cookies.signed[:user_id])
      if user.authenticated?(cookies[:remember_token])
        session[:user_id] = user.id
        user
      end
    end
  end

  def liked?(phrase_id)
    return false unless current_user
    current_user.likes.pluck(:phrase_id).include?(phrase_id)
  end
  
  def login_required
    unless current_user
      session[:forwarding_url] = request.original_url if request.get?
      flash[:danger] = 'ログインしてください'
      redirect_to login_path 
    end
  end

  def logout_required
    if user = current_user
      redirect_to user
    end
  end

  def set_chart(user)
    dataset = { post: {}, like: {}}
    list = {
      post: user.phrases.includes(:tags),
      like: user.liked_phrases.includes(:tags)
    } 
    
    list.each do |key, value|
      hash = Hash.new(0)
      value = value.map{|v| v.tags.pluck(:name) }.flatten
      value.each {|i| hash[i] += 1 }
      hash = Hash[hash.sort{|(k1, v1), (k2, v2)| v2 <=> v1 }]
      dataset[key]["data"] = hash.values[0..5]
      dataset[key]["labels"] = hash.keys[0..5]
    end

    gon.dataset = dataset  
  end
end
