class CategoriesController < ApplicationController
  def index
    @categories = Category.where(ancestry: nil).order(id: :asc)
    @q = current_user.items.ransack(params[:q])
    @search_items = @q.result(distinct: true).where(disposal_method: "before")
  end
end
