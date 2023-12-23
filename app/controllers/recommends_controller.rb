class RecommendsController < ApplicationController
  require 'net/https'
  require 'uri'
  require 'json'
  include TextpairApi
  def show
    @user_items = current_user.items.where(disposal_method: "before")
    category_ids = @user_items.pluck(:category_id)
    similar_items = Item.where(disposal_method: "discard").where(category_id: category_ids)
    @grouped_items = similar_items.group_by(&:category_id).transform_values do |items|
      items.map(&:name)
    end
    #出力例 => {42=>["マスカラ"]}
    if @user_items.present? && @grouped_items.present?
      result_hash = calculate_similarity(@user_items, @grouped_items)
      # 出力例 => {38=>[0.50798434, 0.50239223, 0.50798434, 0.49488837, 0.50798434]}
      count_hash = result_hash.transform_values do |v|
        v.count { |v| v >= 0.6 }
      end
      # {38=>0}
      max_count = count_hash.values.all?(&:zero?) ? nil : count_hash.values.max
      items_with_max_count = max_count ? count_hash.select { |_key, value| value == max_count } : {}
      if items_with_max_count.present?
        @recommend_item = current_user.items.where(id: items_with_max_count.keys).order("RANDOM()").first
      end
    end
    @nearest_item = current_user.items.where(disposal_method: "before").upcoming_notification.first
  end

  private

  def calculate_similarity(user_items, grouped_items)
    similarity_hash = {}
    user_items.each do |user_item|
      user_item_id = user_item.id
      similarities = []

      grouped_items_names = grouped_items[user_item.category_id] || []
      grouped_items_names.each do |grouped_item_name|
        similarity = post_message(user_item.name, grouped_item_name)
        similarities << similarity if similarity
      end
      # ハッシュオブジェクト[キー] = 値で新しい要素を追加
      similarity_hash[user_item_id] = similarities
    end
    return similarity_hash
    # {38=>[0.50798434, 0.50239223, 0.50798434, 0.49488837, 0.50798434]}
  end
end
