FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "name_#{n}" } 
    association :user
    after(:create) do |item|
      create(:notification, item: item)
    end

    after(:build) do |item|
      parent_category = create(:category)
      child_category = parent_category.children.create(title: "トップス")

      item.category_id = child_category.id
    end
  end
end