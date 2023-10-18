class Item < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :category
  has_one :notification, dependent: :destroy
  accepts_nested_attributes_for :notification, allow_destroy: true

  validates :listing_status, inclusion: [true, false]
  validates :disposal_method, inclusion: [true, false]
end
