class Post < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :likes, dependent: :destroy
end
