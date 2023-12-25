class DeclutteringsController < ApplicationController
  before_action :set_decluttering, only: [:edit, :update, :show]

  def show; end

  def edit; end

  def update
    if @decluttering.update(decluttering_params)
      flash.now[:success] = t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def decluttering_params
    params.require(:decluttering).permit(:goal_amount)
  end

  def set_decluttering
    @decluttering = current_user.decluttering
  end
end
