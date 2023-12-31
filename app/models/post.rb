class Post < ApplicationRecord
  mount_uploader :post_image, PostImageUploader
  belongs_to :user
  belongs_to :item
  has_many :likes, dependent: :destroy

  validates :content, length: { maximum: 1000 }

  scope :with_item, -> { eager_load([:user, :item]).where.not(items: { disposal_method: "before" }) }
end
