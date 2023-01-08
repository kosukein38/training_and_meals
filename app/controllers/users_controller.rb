class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create show]

  def show
    @user = User.find(params[:id])
    @input_date = Time.zone.today
    @workouts = @user.workouts.where(workout_date: @input_date.beginning_of_day...@input_date.end_of_day).order(created_at: :desc)
    @meals = @user.meals.includes(:meal_details).where(meal_date: @input_date.beginning_of_day...@input_date.end_of_day).order(created_at: :desc)
    @total_calorie = MealDetail.where(meal_id: @meals.pluck(:id)).pluck(:meal_calorie).sum
  end

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

  def date_search
    user_id = params[:user_id]
    @user = User.find(user_id)
    @input_date = params[:date_search].to_date
    if @input_date
      @workouts = Workout.where(workout_date: @input_date.beginning_of_day...@input_date.end_of_day, user_id:)
      @meals = Meal.where(meal_date: @input_date.beginning_of_day...@input_date.end_of_day, user_id:)
      @total_calorie = MealDetail.where(meal_id: @meals.pluck(:id)).pluck(:meal_calorie).sum
    else
      flash.now[:fail] = t('.fail')
      redirect_to user_path(@user)
    end

    return unless @workouts || @meals

    render :show
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
