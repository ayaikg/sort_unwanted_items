class RecommendsController < ApplicationController
  before_action :set_recommend
  include TextpairApi

  SIMILARITY_THRESHOLD = 0.6

  def show
    return unless @user_items.present? && @grouped_items.present?

    result_hash = calculate_similarity(@user_items, @grouped_items)
    average_hash = change_count_hash(result_hash)
    @recommend_item = fetch_recommend_item(average_hash) if average_hash
  end

  private

  def set_recommend
    @user_items = current_user.items.before_disposal
    category_ids = @user_items.pluck(:category_id)
    similar_items = Item.where(disposal_method: "discard").where(category_id: category_ids)
    @grouped_items = similar_items.group_by(&:category_id).transform_values do |items|
      items.map(&:name)
    end
    @nearest_item = current_user.items.before_disposal.upcoming_notification.first
  end

  def change_count_hash(result_hash)
    change_hash = result_hash.transform_values do |values|
      values.filter { |value| value >= SIMILARITY_THRESHOLD }
    end
    return nil if change_hash.values.all?(&:empty?)

    # デバッグ時にreturnがないと値が返らない
    return change_hash
  end

  def fetch_recommend_item(average_hash)
    average_hash = average_hash.transform_values do |values|
      values.empty? ? 0 : values.sum.to_f / values.size
    end
    max_average = average_hash.values.reject { |v| v == 0 }.max
    return if max_average.nil?

    items_with_max_average = average_hash.select { |_key, value| value == max_average }
    return if items_with_max_average.empty?
    
    item_ids = items_with_max_average.keys
    return current_user.items.random_order(item_ids).first
  end
end
