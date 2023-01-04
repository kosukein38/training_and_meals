class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login
  before_action :set_user

  # ログイン済みユーザーかどうか確認(:require_loginのメソッドに追加)
  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to login_path
  end

  private

  def set_user
    @user = User.find(current_user.id) if logged_in?
  end
end
