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

  def quoted_title
    url? ? url_title : quoted
  end

  def quoted_url
    url = quoted
    if url? && url.length > 30
      url[0..29] + '...'
    else
      url
    end
  end

  def url?
    url_title.present?
  end
end
