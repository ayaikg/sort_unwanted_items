class CategoriesController < ApplicationController
  def index
    @categories = Category.where(ancestry: nil).order(id: :asc)
  end
end
