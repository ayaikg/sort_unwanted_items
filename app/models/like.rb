class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  counter_culture :post

  validates :user_id, uniqueness: { scope: :post_id }
end
