# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    name { 'test_user' }
    content { 'sample comment' }
    phrase
  end
end
