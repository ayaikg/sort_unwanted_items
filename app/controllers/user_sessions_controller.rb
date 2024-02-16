class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:guest_login]
  #   def new; end
  #
  #   def create
  #     @user = login(params[:email], params[:password])
  #
  #     if @user
  #       redirect_back_or_to categories_path
  #     else
  #       render :new
  #     end
  #   end

  def destroy
    current_user.destroy! if current_user.guest?
    logout
    redirect_to(root_path, alert: t('.logout'))
  end

  def guest_login
    redirect_to root_path, error: 'すでにログインしています' if current_user
    random_value = SecureRandom.hex
    random_pass = SecureRandom.hex(10)
    user = User.create!(
      name: "ゲストユーザー",
      email: "test_#{random_value}@example.com",
      password: random_pass,
      password_confirmation: random_pass,
      role: :guest
      )
    auto_login(user)
    redirect_to categories_path, success: 'ゲストとしてログインしました'
  end
end
