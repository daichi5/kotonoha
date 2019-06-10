# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :phrase
  validates :name, presence: true, length: { maximum: 30 }
  validates :content, presence: true, length: { maximum: 200 }
end
