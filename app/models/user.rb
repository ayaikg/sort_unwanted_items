class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader
  
  has_many :categories, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :notifications, through: :items
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  enum role: { general: 0, admin: 1 }

  def own?(object)
    id == object.user_id
  end

  def like(post)
    like_posts << post
  end

  def unlike(post)
    like_posts.destroy(post)
  end

  def like?(post)
    like_posts.include?(post)
  end

  def disposal_data_for_past_week
    items.where(disposed_at: 1.week.ago.to_date..Date.today)
         .where(disposal_method: ["sold", "discard"])
         .group("DATE(disposed_at)")
         .count
  end

  after_create :create_default_categories

  private

  def create_default_categories
    default_categories = %w[衣類 書籍 コスメ 文房具 ゲーム 音楽]

    default_categories.each do |title|
      categories.find_or_create_by(title:)
    end
  end
end
