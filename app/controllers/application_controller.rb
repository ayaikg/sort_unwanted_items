class ApplicationController < ActionController::Base
  add_flash_types :info, :success, :warnig, :error
  before_action :require_login

  private

  def not_authenticated
    flash[:error] = t('defaults.message.require_login')
    redirect_to root_path
  end
end
