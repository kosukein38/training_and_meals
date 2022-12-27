class MealsController < ApplicationController
  before_action :set_user, only: %i[new create]

  def new
    @meal_form = MealForm.new
  end

  def create
    @meal_form = MealForm.new(meal_form_params)
    if @meal_form.save
      redirect_to user_path(@user.id), success: t('defaults.message.created', item: Meal.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Meal.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def meal_form_params
    params.require(:meal_form).permit(:meal_period, :meal_type, :meal_memo,
                                      :meal_title_first, :meal_weight_first, :meal_calorie_first,
                                      :meal_title_second, :meal_weight_second, :meal_calorie_second,
                                      :meal_title_third, :meal_weight_third, :meal_calorie_third,).merge(user_id: current_user.id)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
