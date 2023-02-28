class WorkoutLikesController < ApplicationController
  def create
    workout = Workout.find(params[:workout_id])
    current_user.like_workout(workout)
    redirect_to request.referer
  end

  def destroy
    workout = current_user.workout_likes.find(params[:id]).workout
    current_user.unlike_workout(workout)
    redirect_to request.referer
  end
end
