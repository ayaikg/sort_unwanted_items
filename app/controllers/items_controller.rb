class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy, :show]
  before_action :set_categories, only: [:new, :create, :edit, :update, :history]
  before_action :set_child_categories, only: [:edit, :update]

  def index
    @category = Category.find(params[:category_id])
    category_ids = @category.subtree_ids
    @q = current_user.items.where(category_id: category_ids).with_before_disposal.ransack(params[:q])
    before_items = @q.result(distinct: true)
    @listed_items = before_items.where(listing_status: true)
    @unlisted_items = before_items.where(listing_status: false)
  end

  def search
    @items = current_user.items.search_name(params[:view], params[:q])
    respond_to do |format|
      format.js
    end
  end

  def show; end

  def new
    @item = Item.new
    @item.build_notification # has_oneのオプション、おそらくhas_oneだからnotification.buildがダメだった
  end

  def edit
    @parent_category = @item.category.parent_id
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to categories_path, success: t('.success')
    else
      flash.now[:error] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def history
    @q = current_user.items.after_disposal.ransack(params[:q])
    @disposal_items = @q.result(distinct: true).page(params[:page])
    @categories_collection = @categories.map { |p| [p.title, p.children.map { |c| [c.title, c.id] }] }
  end

  def chart
    chart_datas = current_user.disposal_chart_datas
    gon.disposal_dates = chart_datas[:dates]
    gon.disposal_counts = chart_datas[:counts]
    @before_items = current_user.items.before_disposal.count
  end

  def category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), success: t('.success')
    else
      flash.now[:error] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy!
    redirect_to categories_path, success: t('.success')
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :image, :image_cache, :listing_status, :disposal_method,
                                 :category_id, :color, notification_attributes: [:notify_date])
  end

  def set_item
    @item = current_user.items.find_by(id: params[:id])
    redirect_to(root_path, alert: t('defaults.message.forbidden_access')) unless @item
  end

  def set_categories
    @categories = Category.roots
  end

  def set_child_categories
    @child_categories = @item.category.siblings.order('id ASC')
  end
end
