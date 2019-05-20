class Phrase < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :author, length: { maximum: 15 }
  validates :quoted, length: { maximum: 800 }
  acts_as_taggable

  def quoted_title
    self.url? ? self.url_title : self.quoted
  end

  def quoted_url
    url = self.quoted
    if self.url? && url.length > 30
      url[0..29] + "..."
    else
      url
    end
  end

  def url?
    self.url_title.present?
  end
end
