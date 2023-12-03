FactoryBot.define do
  factory :notification do
    notify_date { Date.tomorrow }
    association :item
  end
end