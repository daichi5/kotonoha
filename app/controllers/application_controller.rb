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

      current_user.likes.find_by(phrase_id: phrase_id)
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
      list = {
        post: user.phrases,
        like: user.liked_phrases
      } 

      dataset = { post: {}, like: {}}
      
      list.each do |key, value|
        hash = Hash.new(0)
        value = value.map(&:tag_list).flatten
        value.each {|i| hash[i] += 1 }
        hash = Hash[hash.sort{|(k1, v1), (k2, v2)| v2 <=> v1 }]
        dataset[key]["data"] = hash.values[0..5]
        dataset[key]["labels"] = hash.keys[0..5]
      end

      gon.dataset = dataset  
    end
end
