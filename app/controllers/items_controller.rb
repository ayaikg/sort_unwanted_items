class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy, :show]

  def show
  end

  def new
    @item = Item.new
  end

  def create
    item = current_user.items.build(item_params)
    if item.save
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to categories_path
  end

  private
  def item_params
    params.require(;items).permit(:name, :price, :image, :listing_status, :disposal_method)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
