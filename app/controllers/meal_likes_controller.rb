class MealLikesController < ApplicationController
  def create
    like = Like.create!(user_id: current_user.id)
    @meal_like = MealLike.new(like_id: like.id, meal_id: params[:meal_id])
    @meal_like.save!
    redirect_to request.referer 
  end

  def destroy
    @meal_like = MealLike.find(params[:id])
    @meal_like.destroy!
    redirect_to request.referer
  end
end
