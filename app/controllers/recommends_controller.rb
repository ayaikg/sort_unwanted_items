class RecommendsController < ApplicationController
  before_action :set_recommend
  require 'net/https'
  require 'uri'
  require 'json'
  include TextpairApi

  def show
    return unless @user_items.present? && @grouped_items.present?

    result_hash = calculate_similarity(@user_items, @grouped_items)
    count_hash = change_count_hash(result_hash)
    @recommend_item = fetch_recommend_item(count_hash) if count_hash
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
      values.count { |value| value >= 0.6 }
    end
    return nil if change_hash.values.all?(&:zero?)
    # returnがないと値が返らない
    return change_hash
  end

  def fetch_recommend_item(count_hash)
    max_count = count_hash.values.max
    items_with_max_count = count_hash.select { |_key, value| value == max_count }
    return if items_with_max_count.blank?

    item_ids = items_with_max_count.keys
    return current_user.items.random_order(item_ids).first
  end
end
