class MealLikesController < ApplicationController
  def create
    meal = Meal.find(params[:meal_id])
    current_user.like_meal(meal)
    redirect_to request.referer
  end

  def destroy
    meal = current_user.meal_likes.find(params[:id]).meal
    current_user.unlike_meal(meal)
    redirect_to request.referer
  end
end
