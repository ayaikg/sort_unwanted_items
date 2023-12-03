FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    sequence(:name) { |m| "user#{m}"}
    password { "password" } 
    password_confirmation { "password" }
  end
end