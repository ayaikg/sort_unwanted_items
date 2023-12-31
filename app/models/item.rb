class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  before_save :set_disposed_at

  belongs_to :user
  belongs_to :category

  has_many :posts, dependent: :destroy
  has_one :notification, dependent: :destroy
  accepts_nested_attributes_for :notification, allow_destroy: true

  validates :listing_status, inclusion: [true, false]
  validates :disposal_method, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 9_999_999,
                            allow_nil: true }

  enum disposal_method: { before: 0, sold: 1, discard: 2 }
  enum color: { nothing: 0, white: 1, black: 2, gray: 3, brown: 4, beige: 5, green: 6, blue: 7, purple: 8, yellow: 9,
                pink: 10, red: 11, orange: 12, gold: 13, silver: 14 }

  scope :before_disposal, -> { where(disposal_method: "before") }
  scope :after_disposal, -> { where.not(disposal_method: "before") }
  scope :upcoming_notification, lambda {
                                  joins(:notification).where('notifications.notify_date > ?', Time.zone.today)
                                                      .order('notifications.notify_date ASC')
                                }
  scope :with_before_disposal, lambda {
                                 includes(:notification).select('items.*, notifications.notify_date')
                                                        .joins(:notification).before_disposal
                               }
  scope :with_after_disposal, -> { select('items.*, notifications.notify_date').joins(:notification).after_disposal }
  scope :search_name, lambda { |view, query|
    items = view == 'history' ? after_disposal : before_disposal
    items.where("name like ?", "%#{query}%")
  }
  scope :random_order, ->(ids) { where(id: ids).order("RANDOM()") }

  private

  def set_disposed_at
    if disposal_method_changed? && (disposal_method == "sold" || disposal_method == "discard")
      self.disposed_at = Date.current
    elsif disposal_method == "before"
      self.disposed_at = nil
    end
  end
end
