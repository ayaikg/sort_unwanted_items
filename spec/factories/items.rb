FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "name_#{n}" } 
    association :user
    association :category
    after(:create) do |item|
      create(:notification, item: item)
    end
  end
end