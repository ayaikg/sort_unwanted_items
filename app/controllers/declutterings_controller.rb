class DeclutteringsController < ApplicationController
  before_action :set_decluttering, only: [:edit, :update, :show]
  def new
    @decluttering = Decluttering.new
  end

  def create
    @decluttering = current_user.build_decluttering(decluttering_params)
    if @decluttering.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @decluttering.update(decluttering_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def show
    # goal_amountが初期値の0の場合は未設定と表示し、それ以外の場合はその値をセット
    @goal_amount = @decluttering.goal_amount.zero? ? "未設定" : @decluttering.goal_amount
    @total_disposed_items = current_user.total_disposed_items
    @difference = display_difference(@goal_amount, @total_disposed_items)
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
end
