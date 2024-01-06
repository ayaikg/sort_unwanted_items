module DeclutteringsHelper
  PERCENTAGE_MULTIPLIER = 100
  ZERO_ITEMS = 0
  def set_rate(decluttering, user)
    if decluttering.goal_amount.zero?
      ZERO_ITEMS
    else
      (user.total_disposed_items.to_f / decluttering.goal_amount * PERCENTAGE_MULTIPLIER).to_i
    end
  end

  def set_difference(decluttering, user)
    if decluttering.goal_amount.zero?
      safe_join([content_tag(:span, 'あと', class: 'text-sm'), ZERO_ITEMS.to_s, content_tag(:span, '個', class: 'text-sm')])
    elsif user.total_disposed_items >= decluttering.goal_amount
      "達成済み"
    else
      remaining_items = decluttering.goal_amount - user.total_disposed_items
      safe_join([content_tag(:span, 'あと', class: 'text-sm'), remaining_items,
                 content_tag(:span, '個', class: 'text-sm')])
    end
  end
end
