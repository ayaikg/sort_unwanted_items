class CategoriesController < ApplicationController
  def index
    @categories = @q_header.result(distinct: true).order(id: :asc) if @q_header
  end
end
