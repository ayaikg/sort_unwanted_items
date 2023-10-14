class Category < ApplicationRecord
  belongs_to :user, optional: true

  validates :title, presence: true, uniqueness: { scope: :user_id }
end
