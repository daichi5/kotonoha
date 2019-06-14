# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :phrases, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_phrases, through: :likes, source: :phrase
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 120 }
  has_one_attached :image

  def get_image
    image.attached? ? image : 'default.png'
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
