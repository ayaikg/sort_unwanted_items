class DeclutteringsController < ApplicationController
  before_action :set_decluttering, only: [:edit, :update, :show]

  def show
    # goal_amountが初期値の0の場合は未設定と表示し、それ以外の場合はその値をセット
    @goal_amount = @decluttering.goal_amount.zero? ? "未設定" : @decluttering.goal_amount
    @total_disposed_items = current_user.total_disposed_items
    @difference = display_difference(@goal_amount, @total_disposed_items)
    @rate = goal_achievement_rate(@decluttering, @total_disposed_items)
    @last_month_items = current_user.last_month_disposed_items
  end

  def edit; end

  def update
    if @decluttering.update(decluttering_params)
      redirect_to decluttering_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def decluttering_params
    params.require(:decluttering).permit(:goal_amount)
  end

  def set_decluttering
    @decluttering = current_user.decluttering
  end

  def display_difference(goal_amount, total_disposed_items)
    if goal_amount == "未設定"
      0
    elsif total_disposed_items >= goal_amount
      "達成済み"
    else
      goal_amount - total_disposed_items
    end
  end

  def goal_achievement_rate(decluttering, total_disposed_items)
    if decluttering.goal_amount.zero?
      0
    else
      total_disposed_items.to_f / decluttering.goal_amount * 100
    end
  end
end
