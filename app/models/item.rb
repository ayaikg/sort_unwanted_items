class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  belongs_to :category

  validates listing_status, inclusion: [true, false]
  validates disposal_method, inclusion: [true, false]
end
