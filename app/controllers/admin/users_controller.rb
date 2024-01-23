module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, only: %i[edit update show destroy]

    def index
      @q = User.ransack(params[:q])
      @users = @q.result(distinct: true).order(id: :asc).page(params[:page])
    end

    def show; end
    def edit; end

    def update
      if @user.update(user_params)
        redirect_to admin_user_path(@user), success: t('defaults.message.updated')
      else
        flash.now[:error] = t('defaults.message.not_updated')
        render :edit
      end
    end

    def destroy
      @user.destroy!
      redirect_to admin_root_path, success: t('defaults.message.deleted')
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name, :avatar, :avatar_cache, :role, :introduction)
    end
  end
end
