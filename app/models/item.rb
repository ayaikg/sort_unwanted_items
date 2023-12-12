class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  before_save :set_disposed_at

  belongs_to :user
  belongs_to :category
  counter_culture :category, column_name: proc { |model| model.disposal_method == "before" ? 'items_count' : nil },
                             column_names: {
                               ["items.disposal_method = ?", "before"] => 'items_count'
                             }

  has_one :post, dependent: :destroy
  has_one :notification, dependent: :destroy
  accepts_nested_attributes_for :notification, allow_destroy: true

  validates :listing_status, inclusion: [true, false]
  validates :disposal_method, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 9_999_999,
                            allow_nil: true }

  enum disposal_method: { before: 0, sold: 1, discard: 2 }
  enum color: { nothing: 0, white: 1, black: 2, gray: 3, brown: 4, beige: 5, green: 6, blue: 7, purple: 8, yellow: 9, pink: 10, red: 11, orange: 12, gold: 13, silver: 14 }

  private

  def set_disposed_at
    if disposal_method_changed? && (disposal_method == "sold" || disposal_method == "discard")
      self.disposed_at = Date.current
    elsif disposal_method == "before"
      self.disposed_at = nil
    end
  end
end
