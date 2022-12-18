class StaticPagesController < ApplicationController
  skip_before_action :require_login
  before_action :set_user

  def top ;end

  private

  def set_user
    @user = User.find(current_user.id) if logged_in?
  end
end
