class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = @q_header.result(distinct: true) if @q_header
  end

  def search
    @categories = current_user.categories.where("title like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.js
    end
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = current_user.categories.build(category_params)
    return if @category.save

    render :new, status: :unprocessable_entity
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy!
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  end
end
