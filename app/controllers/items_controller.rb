class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy, :show]
  before_action :set_categories, only: [:new, :create, :edit, :update]

  def index
    return unless params[:category_id].present?

    @category = current_user.categories.find(params[:category_id])
    @q = @category.items.ransack(params[:q])
    @listed_items = @q.result(distinct: true).includes(:user).where(listing_status: true, disposal_method: 0)
    @unlisted_items = @q.result(distinct: true).includes(:user).where(listing_status: false, disposal_method: 0)
  end

  def search
    @items = current_user.items.where.not(disposal_method: 0).where("name like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.js
    end
  end

  def show; end

  def new
    @item = Item.new
    @item.build_notification # has_oneのオプション、おそらくhas_oneだからnotification.buildがダメだった
  end

  def edit; end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def history
    @q = current_user.items.ransack(params[:q])
    @disposal_items = @q.result(distinct: true).includes(:user).where.not(disposal_method: 0)
  end

  def chart
    # 過去１週間の断捨離アイテム数を取得
    disposal_datas = current_user.disposal_data_for_past_week
    # 過去1週間の全日についてデータを保証する
    dates = (1.week.ago.to_date..Date.today).map { |date| date.strftime('%Y-%m-%d') }
    counts = dates.map { |date| disposal_datas[date.to_date].to_i }

    gon.disposal_dates = dates
    gon.disposal_counts = counts
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
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
