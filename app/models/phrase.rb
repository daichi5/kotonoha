class Phrase < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true
  validates :url, format: /\A#{URI::regexp(%w(http https))}\z/, allow_blank: true
end
