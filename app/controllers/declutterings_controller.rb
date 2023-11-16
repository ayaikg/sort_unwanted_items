class DeclutteringsController < ApplicationController
  before_action :set_decluttering, only: [:edit, :update]
  def new
    @decluttering = Decluttering.new
  end

  def create
    @decluttering = Decluttering.new(decluttering_params)
    if @decluttering.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @decluttering.update(decluttering_params)
      redirect_to user_path(current_user)
    else
      render :edit
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
