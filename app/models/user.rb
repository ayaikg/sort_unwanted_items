class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  has_one :decluttering, dependent: :destroy
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
         .where(disposal_method: %w[sold discard])
         .group("DATE(disposed_at)")
         .count
  end

  def last_month_disposed_items
    items.where(disposed_at: Date.today.last_month.all_month)
         .where(disposal_method: %w[sold discard])
         .count
  end

  def total_disposed_items
    items.where(disposed_at: Date.today.beginning_of_month..Date.today)
         .where(disposal_method: %w[sold discard])
         .count
  end

  after_create :create_default_categories, :create_default_decluttering

  private

  def create_default_categories
    default_categories = [
      { title: 'ファッション', icon: File.open(Rails.root.join('public', 'images', 'category_clothes.png')) },
      { title: '書籍', icon: File.open(Rails.root.join('public', 'images', 'category_book.png')) },
      { title: 'コスメ', icon: File.open(Rails.root.join('public', 'images', 'category_cosme.png')) },
      { title: 'ゲーム', icon: File.open(Rails.root.join('public', 'images', 'category_game.png')) },
      { title: '音楽', icon: File.open(Rails.root.join('public', 'images', 'category_music.png')) },
      { title: 'ぬいぐるみ', icon: File.open(Rails.root.join('public', 'images', 'category_doll.png')) },
      { title: 'その他' }
    ]
    default_categories.each do |category|
      categories.find_or_create_by(title: category[:title]) do |c|
        c.icon = category[:icon]
        c.save!
      end
    end
  end

  def create_default_decluttering
    create_decluttering(goal_amount: 0)
  end
end
