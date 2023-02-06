class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to profile_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, success: t('.success')
  end

  def guest_login
    @guest_user = User.new(
      email: 'guestuser.bulkupper@example.com',
      name: 'ゲスト',
      password: 'password',
      password_confirmation: 'password',
      role: 2
      )
    if @guest_user.save
      auto_login(@guest_user)
    else
      @guest_user = User.find_by(
        email: 'guestuser.bulkupper@example.com'
      )
      auto_login(@guest_user)
    end
    redirect_to root_path, success: 'ゲストとしてログインしました'
  end
end
