class Category < ApplicationRecord
  before_destroy :reassign_items
  
  mount_uploader :icon, IconUploader
  belongs_to :user
  has_many :items

  validates :title, presence: true, uniqueness: { scope: :user_id }

  private
  def reassign_items
    default_category = user.categories.find_by(title: 'その他')
    items.update_all(category_id: default_category.id)
  end
end
