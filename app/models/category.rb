class Category < ApplicationRecord
  mount_uploader :icon, IconUploader
  belongs_to :user
  has_many :items

  validates :title, presence: true
end
