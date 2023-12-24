class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy, :show]
  before_action :set_categories, only: [:new, :create, :edit, :update]
  before_action :set_child_categories, only: [:edit, :update]

  def index
    @category = Category.find(params[:category_id])
    child_categories = @category.descendants.pluck(:id)
    category_ids = child_categories << @category.id
    @q = Item.where(category_id: category_ids).ransack(params[:q])
    before_items = @q.result(distinct: true).includes(:notification)
                     .select('items.*, notifications.notify_date').joins(:notification)
                     .where(disposal_method: "before").where(user_id: current_user.id)
    @listed_items = before_items.where(listing_status: true)
    @unlisted_items = before_items.where(listing_status: false)
  end

  def search
    if params[:view] == 'history'
      @items = current_user.items.where.not(disposal_method: "before").where("name like ?", "%#{params[:q]}%")
    elsif params[:view] == 'index'
      @items = current_user.items.where(disposal_method: "before").where("name like ?", "%#{params[:q]}%")
    end
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
    @q = current_user.items.ransack(params[:q])
    @disposal_items = @q.result(distinct: true)
                        .select('items.*, notifications.notify_date').joins(:notification)
                        .where.not(disposal_method: "before").page(params[:page]).per(20)
    @categories_collection = Category.where(ancestry: nil).map { |p| [p.title, p.children.map { |c| [c.title, c.id] }] }
  end

  def chart
    # 過去１週間の断捨離アイテム数を取得
    disposal_datas = current_user.disposal_data_for_past_week
    # 過去1週間の全日についてデータを保証する
    dates = (1.week.ago.to_date..Time.zone.today).map { |date| date.strftime('%Y-%m-%d') }
    counts = dates.map { |date| disposal_datas[date.to_date].to_i }

    gon.disposal_dates = dates
    gon.disposal_counts = counts

    @before_items = current_user.items.where(disposal_method: "before").count
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
    @categories = Category.where(ancestry: nil)
  end

  def set_child_categories
    @child_categories = @item.category.siblings.order('id ASC')
  end
end
