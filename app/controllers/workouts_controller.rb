class WorkoutsController < ApplicationController
  skip_before_action :require_login, only: %i[show]

  def show
    @workout = Workout.find(params[:id])
    @user =User.find(@workout.user_id)
  end

  def new
    @workout_form = WorkoutForm.new
  end

  def edit
    @workout_form = current_user.workouts.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @workout_form.nil?
  end

  def create
    @workout_form = WorkoutForm.new(workout_form_params)
    if @workout_form.save
      redirect_to user_path(current_user), success: t('defaults.message.created', item: Workout.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Workout.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @workout_form = WorkoutForm.new(workout_params)
    if @workout_form.update
      redirect_to user_path(current_user), success: t('defaults.message.updated', item: Workout.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Workout.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @workout = current_user.workouts.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @workout.nil?
    @workout.destroy!
    redirect_to user_path(current_user), success: t('defaults.message.deleted', item: Workout.model_name.human)
  end

  private

  def workout_form_params
    params.require(:workout_form).permit(:workout_date, :workout_title, :workout_time,
                                         :workout_weight, :repetition_count,
                                         :set_count, :workout_memo, body_part_ids: [], workout_images: []).merge(user_id: current_user.id)
  end

  def workout_params
    params.require(:workout).permit(:workout_date, :workout_title, :workout_time,
                                    :workout_weight, :repetition_count,
                                    :set_count, :workout_memo, body_part_ids: [], workout_images: []).merge(user_id: current_user.id, workout_id: params[:id])
  end
end
