class Comment < ApplicationRecord
  belongs_to :phrase
  validates :name, presence: true
  validates :content, presence: true
end
