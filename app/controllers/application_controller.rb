# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :liked?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :description, :image])
  end

  private

  def liked?(phrase_id)
    return false unless current_user

    current_user.likes.pluck(:phrase_id).include?(phrase_id)
  end

  def set_chart(user)
    dataset = { post: {}, like: {} }
    list = {
      post: user.phrases.includes(:tags),
      like: user.liked_phrases.includes(:tags)
    }

    list.each do |key, value|
      hash = Hash.new(0)
      value = value.map { |v| v.tags.pluck(:name) }.flatten
      value.each { |i| hash[i] += 1 }
      hash = Hash[hash.sort { |(_k1, v1), (_k2, v2)| v2 <=> v1 }]
      dataset[key]['data'] = hash.values[0..5]
      dataset[key]['labels'] = hash.keys[0..5]
    end

    gon.dataset = dataset
  end
end
