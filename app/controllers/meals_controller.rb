class MealsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @meals = Meal.includes(:user, :meal_details).order(meal_date: :desc).page(params[:page])
  end

  def show
    @meal = Meal.find(params[:id])
    @user = @meal.user
  end

  def new
    @meal_form = MealForm.new
  end

  def edit
    load_meal

    @meal_form = MealForm.new(meal: @meal)
    redirect_to root_url, status: :see_other if @meal_form.nil?
  end

  def create
    @meal_form = MealForm.new(meal_params)
    if @meal_form.save
      redirect_to user_path(current_user.id), success: t('defaults.message.created', item: Meal.model_name.human)
    else
      flash.now['error'] = t('defaults.message.not_created', item: Meal.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    load_meal

    @meal_form = MealForm.new(meal_params, meal: @meal)
    if @meal_form.save
      if params.dig(:meal, :meal_images)[1].present?
        images = ActiveStorage::Attachment.where(record_id: params[:id])
        images.each(&:purge)
        @meal.meal_images.attach(params[:meal][:meal_images])
      end
      redirect_to user_path(current_user), success: t('defaults.message.updated', item: Meal.model_name.human)
    else
      flash.now['error'] = t('defaults.message.not_updated', item: Meal.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal = current_user.meals.find(params[:id])
    redirect_to root_url, status: :see_other if @meal.nil?
    @meal.destroy!
    redirect_to user_path(current_user), success: t('defaults.message.deleted', item: Meal.model_name.human)
  end

  def calorie_search
    translated_text = DeeplService.new(params[:calorie_search]).call
    @response = NutritionService.new(translated_text).call
    @response << 'すみません...見つかりませんでした' if @response.empty?
    @meal_form = MealForm.new
    render :new
  end

  def meals_feed
    @feed_items = Meal.where(user_id: [*current_user.following_ids]).order(meal_date: :desc).page(params[:page])
  end

  private

  def meal_params
    params.require(:meal).permit(:meal_date, :meal_period, :meal_type, :meal_memo,
                                 :meal_title_first, :meal_weight_first, :meal_calorie_first,
                                 :meal_title_second, :meal_weight_second, :meal_calorie_second,
                                 :meal_title_third, :meal_weight_third, :meal_calorie_third,
                                 meal_images: []).merge(user_id: current_user.id)
  end

  def load_meal
    @meal = current_user.meals.find(params[:id])
  end
end
