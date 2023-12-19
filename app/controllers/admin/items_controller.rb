class Admin::ItemsController < Admin::BaseController
  before_action :set_item, only: %i[edit update show destroy]
  before_action :set_categories, only: [:edit, :update]
  before_action :set_child_categories, only: [:edit, :update]

  def index
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).includes(:user).order(id: :asc).page(params[:page])
    @categories_collection = Category.where(ancestry: nil).map { |p| [p.title, p.children.map { |c| [c.title, c.id] }] }
  end

  def show; end

  def edit
    @parent_category = @item.category.parent_id
  end

  def update
    if @item.update(item_params)
      redirect_to admin_item_path(@item), success: t('defaults.message.updated')
    else
      flash.now[:error] = t('defaults.message.not_updated')
      render :edit, status: :unprocessable_entity
    end
  end

  def category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  def destroy
    @item.destroy!
    redirect_to admin_items_path, success: t('defaults.message.deleted')
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :image, :image_cache, :listing_status, :disposal_method,
                                 :category_id, :color, notification_attributes: [:notify_date])
  end

  def set_categories
    @categories = Category.where(ancestry: nil)
  end

  def set_child_categories
    @child_categories = @item.category.siblings.order('id ASC')
  end
end
