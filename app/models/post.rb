class Post < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :likes, dependent: :destroy

  ransacker :likes_count do
    query = '(SELECT COUNT(*) FROM likes WHERE likes.post_id = posts.id)'
    Arel.sql(query)
  end
end
