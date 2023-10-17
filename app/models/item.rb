class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates listing_status, inclusion: [true, false]
  validates disposal_method, inclusion: [true, false]
end
