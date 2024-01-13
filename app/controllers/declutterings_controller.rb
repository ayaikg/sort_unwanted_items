class DeclutteringsController < ApplicationController
  before_action :set_decluttering, only: [:edit, :update, :show]

  def show
    chart_datas = current_user.disposal_chart_datas
    gon.disposal_dates = chart_datas[:dates]
    gon.disposal_counts = chart_datas[:counts]
    @before_items = current_user.items.before_disposal.count
  end

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
