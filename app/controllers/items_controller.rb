class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy, :show, :edit_disposal_method]
  before_action :set_categories, only: [:new, :create, :edit, :update]

  def show; end

  def index
    return unless params[:category_id].present?

    @category = current_user.categories.find(params[:category_id])
    @listed_items = @category.items.includes(:user).where(listing_status: true, disposal_method: 0)
    @unlisted_items = @category.items.includes(:user).where(listing_status: false, disposal_method: 0)
  end

  def new
    @item = Item.new
    @item.build_notification # has_oneのオプション、おそらくhas_oneだからnotification.buildがダメだった
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to categories_path
    else
      flash.now[:notice] = "アイテムの作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def edit_disposal_method; end

  def history
    @disposal_items = current_user.items.includes(:user).where.not(disposal_method: 0)
  end

  def update
    if @item.update(item_params)
      if @item.saved_change_to_disposal_method?
        redirect_to items_path(category_id: @item.category_id)
      else
        redirect_to item_path(@item)
      end
    elsif params[:item][:disposal_method]
      render :edit_disposal_method, status: :unprocessable_entity
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy!
    redirect_to categories_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :image, :image_cache, :listing_status, :disposal_method, :category_id,
                                 notification_attributes: [:notify_date])
  end

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def set_categories
    @categories = Category.where(user_id: current_user.id)
  end
end
