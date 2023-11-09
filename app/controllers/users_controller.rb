class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user.name)
    else
      redirect_to edit_user_path(current_user.name)
    end
  end

  private

  def set_user
    @user = User.find_by(name: params[:name])
    redirect_to user_path(@user) unless current_user?(@user)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar, :introduction, :name)
  end
end
