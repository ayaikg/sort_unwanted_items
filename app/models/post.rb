class Post < ApplicationRecord
  mount_uploader :post_image, PostImageUploader
  belongs_to :user
  belongs_to :item
  has_many :likes, dependent: :destroy

  validates :content, length: { maximum: 1000 }
end
