module DeclutteringsHelper
  def set_rate(decluttering, user)
    if decluttering.goal_amount.zero?
      0
    else
      (user.total_disposed_items.to_f / decluttering.goal_amount * 100).to_i
    end
  end

  def set_difference(decluttering, user)
    if decluttering.goal_amount.zero?
      content_tag(:span, 'あと', class: 'text-sm') + '0' + content_tag(:span, '個', class: 'text-sm')
    elsif user.total_disposed_items >= decluttering.goal_amount
      "達成済み"
    else
      content_tag(:span, 'あと', class: 'text-sm') + (decluttering.goal_amount - user.total_disposed_items).to_s + content_tag(:span, '個', class: 'text-sm')
    end
  end
end
