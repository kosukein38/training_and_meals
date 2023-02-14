class WorkoutsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @workouts = Workout.includes(:user).order(workout_date: :desc).page(params[:page])
  end

  def show
    @workout = Workout.find(params[:id])
    @user = User.find(@workout.user_id)
  end

  def new
    @workout_form = WorkoutForm.new
  end

  def edit
    load_workout

    @workout_form = WorkoutForm.new(workout: @workout)
    redirect_to root_url, status: :see_other if @workout_form.nil?
  end

  def create
    @workout_form = WorkoutForm.new(workout_params)
    if @workout_form.save
      redirect_to user_path(current_user), success: t('defaults.message.created', item: Workout.model_name.human)
    else
      flash.now['error'] = t('defaults.message.not_created', item: Workout.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    load_workout

    @workout_form = WorkoutForm.new(workout_params, workout: @workout)
    if @workout_form.save
      if params.dig(:workout, :workout_images)[1].present?
        images = ActiveStorage::Attachment.where(record_id: params[:id])
        images.each(&:purge)
        @workout.workout_images.attach(params[:workout][:workout_images])
      end
      redirect_to user_path(current_user), success: t('defaults.message.updated', item: Workout.model_name.human)
    else
      flash.now['error'] = t('defaults.message.not_updated', item: Workout.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @workout = current_user.workouts.find(params[:id])
    redirect_to root_url, status: :see_other if @workout.nil?
    @workout.destroy!
    redirect_to user_path(current_user), success: t('defaults.message.deleted', item: Workout.model_name.human)
  end

  def workouts_feed
    @feed_items = Workout.where(user_id: [*current_user.following_ids]).order(workout_date: :desc).page(params[:page])
  end

  private

  def workout_params
    params.require(:workout).permit(:workout_date, :workout_title, :workout_time,
                                    :workout_weight, :repetition_count,
                                    :set_count, :workout_memo,
                                    body_part_ids: [], workout_images: []).merge(user_id: current_user.id)
  end

  def load_workout
    @workout = current_user.workouts.find(params[:id])
  end
end
