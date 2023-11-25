class Category < ApplicationRecord
  mount_uploader :icon, IconUploader
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :title, presence: true
end
