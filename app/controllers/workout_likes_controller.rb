class WorkoutLikesController < ApplicationController
  def index
    workout = Workout.find(params[:workout_id])
    @users = workout.workout_like_users.page(params[:page])
  end

  def create
    @workout = Workout.find(params[:workout_id])
    current_user.like_workout(@workout)
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.turbo_stream
    end
  end

  def destroy
    @workout = current_user.workout_likes.find(params[:id]).workout
    current_user.unlike_workout(@workout)
    respond_to do |format|
      format.html { redirect_to request.referer, status: :see_other }
      format.turbo_stream
    end
  end
end
