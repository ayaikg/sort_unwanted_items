class ApplicationController < ActionController::Base
  add_flash_types :info, :success, :warnig, :error
  before_action :require_login
  before_action :set_search

  private

  def not_authenticated
    flash[:error] = t('defaults.message.require_login')
    redirect_to login_path
  end

  def set_search
    case "#{params[:controller]}##{params[:action]}"
    when 'items#index'
      @category = current_user.categories.find(params[:category_id])
      @q_header = @category.items.ransack(params[:q])
    when 'items#history'
      @q_header = current_user.items.ransack(params[:q])
    when 'categories#index'
      @q_header = current_user.categories.ransack(params[:q])
    when 'posts#index'
      @q_header = Post.ransack(params[:q])
    when 'posts#likes'
      @q_header = current_user.like_posts.ransack(params[:q])
    end
  end
end
