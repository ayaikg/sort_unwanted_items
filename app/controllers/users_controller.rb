class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    # decluttering がある場合は、goal_amountを取得し、ない場合は0をセット
    @goal_amount = @user.decluttering&.goal_amount || 0
    @total_disposed_items = @user.total_disposed_items
    @difference = display_difference(@goal_amount, @total_disposed_items)
    @user_posts = @user.posts.includes(:item).order(created_at: :desc)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar, :introduction, :name)
  end
  
  def display_difference(goal_amount, total_disposed_items)
    if goal_amount == 0
      0
    elsif total_disposed_items >= goal_amount
      "達成済み"
    else
      goal_amount - total_disposed_items
    end
  end
end
