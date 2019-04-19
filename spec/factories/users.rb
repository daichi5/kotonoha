FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    description { '自己紹介文' }
  end
end
