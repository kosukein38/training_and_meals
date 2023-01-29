class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login

  private

  # ログイン済みユーザーかどうか確認(:require_loginのメソッドに追加)
  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to main_app.login_path #rails_admin
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, alert: exception.message
  end
end
