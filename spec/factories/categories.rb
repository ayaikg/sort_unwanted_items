FactoryBot.define do
  factory :category do
    sequence(:title) { |n| "title_#{n}" } 
    association :user
  end
end