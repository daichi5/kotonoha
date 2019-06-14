# frozen_string_literal: true

class Phrase < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { maximum: 150 }
  validates :content, length: { maximum: 200 }
  validates :author, length: { maximum: 50 }
  validates :quoted, length: { maximum: 800 }

  scope :search_with, ->(q) { ransack(title_or_content_or_quoted_or_url_title_cont: q).result(distinct: true) }
  scope :set_buttons, lambda {
    includes(:tags).left_joins(:likes, :comments).group(:id).select('phrases.*, COUNT(likes.id) AS likes_count, COUNT(comments.id) AS comments_count')
  }
  acts_as_taggable

  def save_url_title(url)
    if self&.quoted != url
      scraping_title(url)
    else
      self.url_title
    end
  end

  def scraping_title(url)
    title = Nokogiri::HTML.parse(open(url)).title
    title.length > 30 ? (title[0..29] + '...') : title
  rescue StandardError
    nil
  end

  def access_count(ip)
    redis = Redis.current
    key = ip.to_s + ":" + self.id.to_s
    date = Date.today.strftime(format = '%Y%m%d')
    unless redis.exists(key)
      ttl = 60 * 60 * 3
      redis.zincrby(date, 1, self.id)
      redis.set(key, true)
      redis.expire(key, ttl)
    end
    redis.zscore(date, self.id).to_i
  end
end
