class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
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

  def destroy
    logout
    redirect_to login_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar, :introduction, :name)
  end
end
