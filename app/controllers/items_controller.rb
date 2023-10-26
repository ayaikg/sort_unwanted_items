class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy, :show, :edit_disposal_method, :update_disposal_method]

  def show
  end

  def index
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @listed_items = @category.items.includes(:user).where(listing_status: true, disposal_method: 0)
      @unlisted_items = @category.items.includes(:user).where(listing_status: false, disposal_method: 0)
    end
  end

  def new
    @item = Item.new
    @item.build_notification #has_oneのオプション、おそらくhas_oneだからnotification.buildがダメだった
    @categories = Category.where(user_id: current_user.id)
  end

  def create
    item = current_user.items.build(item_params)
    if item.save
      redirect_to categories_path
    else
      flash.now[:notice] = "アイテムの作成に失敗しました"
      render :new
    end
  end

  def edit
    @categories = Category.where(user_id: current_user.id)
  end

  def edit_disposal_method
  end

  def history
    @disposal_items = Item.where.not(disposal_method: 0)
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def update_disposal_method
    if @item.update(item_params)
      
    else
      render :edit_disposal_method
    end
  end

  def destroy
    @item.destroy
    redirect_to categories_path
  end

  private
  def item_params
    params.require(:item).permit(:name, :price, :image, :image_cache, :listing_status, :disposal_method, :category_id,
      notification_attributes: [:notify_date])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
