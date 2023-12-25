module DeclutteringsHelper
  def set_goal_amount(decluttering)
    # goal_amountが初期値の0の場合は未設定と表示し、それ以外の場合はその値をセット
    decluttering.goal_amount.zero? ? "未設定" : decluttering.goal_amount
  end

  def set_rate(decluttering, user)
    if decluttering.goal_amount.zero?
      0
    else
      (user.total_disposed_items.to_f / decluttering.goal_amount * 100).to_i
    end
  end

  def set_difference(decluttering, user)
    if decluttering.goal_amount == "未設定"
      0
    elsif user.total_disposed_items >= decluttering.goal_amount
      "達成済み"
    else
      decluttering.goal_amount - user.total_disposed_items
    end
  end
end