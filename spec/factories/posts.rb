FactoryBot.define do
  factory :post do
    content {"こんにちは"}
    association :item
    association :user
  end
end