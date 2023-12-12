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
      @category = Category.find(params[:category_id])
      child_categories = @category.descendants.pluck(:id)
      category_ids = child_categories << @category.id
      @q_header = Item.where(category_id: category_ids).ransack(params[:q])
    when 'items#history'
      @q_header = current_user.items.ransack(params[:q])
    when 'categories#index'
      @q_header = Category.roots.ransack(params[:q])
    when 'posts#index'
      @q_header = Post.ransack(params[:q])
    when 'posts#likes'
      @q_header = current_user.like_posts.ransack(params[:q])
    end
  end
end
