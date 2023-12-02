FactoryBot.define do
  factory :category do
    sequence(:title, "title_1")
    association :user
  end
end