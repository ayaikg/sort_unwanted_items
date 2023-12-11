class Category < ApplicationRecord
  has_many :items, dependent: :destroy
  has_ancestry

  validates :title, presence: true
end
