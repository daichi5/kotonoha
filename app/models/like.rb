# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :phrase
  validates :user_id, uniqueness: { scope: :phrase_id, message: 'は既にいいねしています' }
end
