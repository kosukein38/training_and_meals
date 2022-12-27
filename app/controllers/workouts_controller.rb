class WorkoutsController < ApplicationController
  before_action :set_user, only: %i[new show create edit update destroy]
  before_action :set_workout, only: %i[show edit destroy]

  def show; end

  def new
    @workout_form = WorkoutForm.new(@workout)
  end

  def edit
    @workout_form = Workout.find(params[:id])
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

  def update
    @workout_form = WorkoutForm.new(workout_params)
    if @workout_form.update
      redirect_to user_path(@user.id), success: t('defaults.message.updated', item: Workout.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Workout.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @workout.destroy!
    redirect_to user_path(@user.id), success: t('defaults.message.deleted', item: Workout.model_name.human)
  end

  private

  def workout_form_params
    params.require(:workout_form).permit(:workout_date, :workout_title, :workout_time,
                                         :workout_weight, :repetition_count,
                                         :set_count, :workout_memo, body_part_ids: []).merge(user_id: current_user.id)
  end

  def workout_params
    params.require(:workout).permit(:workout_date, :workout_title, :workout_time,
                                    :workout_weight, :repetition_count,
                                    :set_count, :workout_memo, body_part_ids: []).merge(user_id: current_user.id, workout_id: params[:id])
  end

  def set_user
    @user = User.find(current_user.id)
  end

  def set_workout
    @workout = current_user.workouts.find(params[:id])
  end
end
