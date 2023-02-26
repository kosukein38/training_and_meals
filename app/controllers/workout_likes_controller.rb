class WorkoutLikesController < ApplicationController
  def create
    like = Like.create!(user_id: current_user.id)
    @workout_like = WorkoutLike.new(like_id: like.id, workout_id: params[:workout_id])
    @workout_like.save!
    redirect_to request.referer
  end

  def destroy
    @workout_like = WorkoutLike.find(params[:id])
    @workout_like.destroy!
    redirect_to request.referer
  end
end
