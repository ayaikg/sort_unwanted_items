class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @user_posts = @user.posts.includes(:item).order(created_at: :desc).page(params[:page]).per(5)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), success: t('.success')
    else
      flash.now[:error] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    return if @user == current_user

    redirect_to current_user, error: t('defaults.message.forbidden_access')
  end

  def user_params
    params.require(:user).permit(:avatar, :avatar_cache, :introduction, :name)
  end
end
