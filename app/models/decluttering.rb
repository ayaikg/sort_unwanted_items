class Decluttering < ApplicationRecord
  belongs_to :user

  validates :goal_amount, presence: true, numericality: { only_integer: true }
end
