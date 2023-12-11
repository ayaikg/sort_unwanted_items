class CategoriesController < ApplicationController
  def index
    @categories = @q_header.result(distinct: true).order(id: :asc) if @q_header
  end

  def search
    @categories = current_user.categories.where("title like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.js
    end
  end
end
