class Notification < ApplicationRecord
  belongs_to :item

  validates :notify_date, presence: true
end
