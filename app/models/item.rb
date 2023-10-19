class Item < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :category
  has_one :notification, dependent: :destroy
  accepts_nested_attributes_for :notification, allow_destroy: true

  validates :listing_status, inclusion: [true, false]
  validates :disposal_method, inclusion: [true, false]
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 9_999_999 }
end
