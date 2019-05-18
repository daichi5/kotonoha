class Phrase < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true

  def quoted_title
    if self.url?
      self.url_title
    else
      self.quoted
    end
  end

  def quoted_url
    url = self.quoted
    if self.url? && url.length > 30
        url = url[0..29] + "..."
    else
      url
    end
  end

  def url?
    if !self.url_title.blank?
      true
    end
  end
end
