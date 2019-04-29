FactoryBot.define do
  factory :phrase do
    title { "sample word" }
    content { "sample description" }
    user
  end
end
