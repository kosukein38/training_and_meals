class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to user_path(@user), success: t('.success')
    else
      flash.now[:error] = t('.fail')
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
    unless @guest_user.save
      @guest_user = User.find_by(
        email: 'guestuser.bulkupper@example.com'
      )
    end
    auto_login(@guest_user)
    redirect_to user_path(@guest_user), success: 'ゲストとしてログインしました'
  end
end
