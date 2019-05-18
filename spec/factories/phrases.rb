FactoryBot.define do
  factory :phrase do
    title { "sample word" }
    content { "sample description" }
    url {"http://test.com/"}
    user
  end
end
