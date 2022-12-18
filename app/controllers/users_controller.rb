class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: t('.success')
    else
      flash.now['danger'] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(current_user.id)
    @workouts = Workout.includes(:user).order(created_at: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_workout
    @board = current_user.workouts.find(params[:id])
  end
end
