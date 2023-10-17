class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :categories, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  enum role: { general: 0, admin: 1 }

  after_create :create_default_categories

  private

  def create_default_categories
    default_categories = ['衣類', '書籍', 'コスメ', '文房具', 'ゲーム', '音楽']
    
    default_categories.each do |title|
      categories.find_or_create_by(title: title)
    end
  end
end
