class CategoriesController < ApplicationController
  def index
    @categories = Category.roots.order(id: :asc)
    @q = current_user.items.before_disposal.ransack(params[:q])
    @items = @q.result(distinct: true)
  end
end
