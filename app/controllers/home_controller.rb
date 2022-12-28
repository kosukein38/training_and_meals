class HomeController < ApplicationController
  before_action :set_user, only: %i[workouts meals]

  def workouts
    @workouts = Workout.includes(:user).order(created_at: :desc)
  end

  def meals
    @meals = Meal.includes(:user, :meal_details).order(created_at: :desc)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
