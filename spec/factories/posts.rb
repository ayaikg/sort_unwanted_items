FactoryBot.define do
  factory :post do
    association :item
    association :user
  end
end