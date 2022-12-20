class WorkoutsController < ApplicationController
  before_action :set_user, only: %i[new show create]
  before_action :set_workout, only: %i[show]

  def show ;end

  def new
    @workout_form = WorkoutForm.new
    @body_part_names = BodyPart.pluck(:body_part_name)
  end

  def create
    @workout_form = WorkoutForm.new(workout_form_params)
    if @workout_form.save
      redirect_to user_path(@user.id), success: t('defaults.message.created', item: Workout.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Workout.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def workout_form_params
    params.require(:workout_form).permit(:workout_date, :workout_title, :workout_time, :workout_weight, :repetition_count, :set_count, :workout_memo, body_part_ids: []).merge(user_id: current_user.id)
  end

  def set_user
    @user = User.find(current_user.id)
  end

  def set_workout
    @workout = current_user.workouts.find(params[:id])
  end
end
