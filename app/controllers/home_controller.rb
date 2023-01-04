class HomeController < ApplicationController
  skip_before_action :require_login

  def workouts
    @workouts = Workout.includes(:user).order(created_at: :desc)
  end

  def meals
    @meals = Meal.includes(:user, :meal_details).order(created_at: :desc)
  end
end
