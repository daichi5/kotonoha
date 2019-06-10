# frozen_string_literal: true

FactoryBot.define do
  factory :phrase do
    title { 'sample word' }
    content { 'sample description' }
    quoted { 'http://test.com/' }
    user
  end
end
