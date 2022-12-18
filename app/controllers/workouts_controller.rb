class WorkoutsController < ApplicationController
  before_action :set_user, only: %i[new show]
  before_action :set_workout, only: %i[show]

  def show ;end

  def new
    @workout = Workout.new
  end

  def create
    @workout = current_user.workouts.build(workout_params)
    if @workout.save
      redirect_to user_path(@workout.user_id), success: t('defaults.message.created', item: Workout.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Workout.model_name.human)
      render :new
    end
  end

  private

  def workout_params
    params.require(:workout).permit(:workout_date, :workout_title, :workout_time, :workout_weight, :repetition_count, :set_count, :workout_memo)
  end

  def set_user
    @user = User.find(current_user.id)
  end

  def set_workout
    @workout = current_user.workouts.find(params[:id])
  end
end
