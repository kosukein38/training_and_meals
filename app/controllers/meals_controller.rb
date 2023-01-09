require 'uri'
require 'net/http'
require 'openssl'

class MealsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_response, only: %i[new edit]

  def index
    @meals = Meal.includes(:user, :meal_details).order(meal_date: :desc)
  end

  def show
    @meal = Meal.find(params[:id])
    @user = User.find(@meal.user_id)
  end

  def new
    @meal_form = MealForm.new
  end

  def edit
    @meal_form = current_user.meals.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @meal_form.nil?
  end

  def create
    @meal_form = MealForm.new(meal_form_params)
    if @meal_form.save
      redirect_to user_path(current_user.id), success: t('defaults.message.created', item: Meal.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Meal.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @meal_form = MealForm.new(meal_params)

    if @meal_form.update
      redirect_to user_path(current_user), success: t('defaults.message.updated', item: Meal.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Meal.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal = current_user.meals.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @meal.nil?
    @meal.destroy!
    redirect_to user_path(current_user), success: t('defaults.message.deleted', item: Meal.model_name.human)
  end

  def calorie_search
    text = params[:calorie_search]
    # APIキーを定義
    deepl_api_key = Rails.application.credentials.deepl[:api_key]
    # リクエストURLを定義
    deepl_api_url = URI('https://api-free.deepl.com/v2/translate')
    # リクエストパラメーターを定義
    req_params = {
      auth_key: deepl_api_key,
      text:,
      target_lang: 'EN',
      source_lang: 'JA'
    }
    # リクエストを送信し、返ってきたレスポンスを変数responseに格納
    response = Net::HTTP.post_form(deepl_api_url, req_params)
    result_body = JSON.parse(response.body)
    translated_text = result_body['translations'][0]['text']
    # translated_textをクエリに含ませ、Nutrition by API-NinjasのAPIを叩く
    nutrition_url = URI("https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?query=#{translated_text}")

    http = Net::HTTP.new(nutrition_url.host, nutrition_url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(nutrition_url)
    request['X-RapidAPI-Key'] = Rails.application.credentials.nutrition[:api_key]
    request['X-RapidAPI-Host'] = 'nutrition-by-api-ninjas.p.rapidapi.com'

    response = http.request(request)
    results = JSON.parse(response.body)
    final_results = []
    results.each do |result|
      final_results << "メニュー：#{result['name']} カロリー：#{result['calories']} kcal グラム数：#{result['serving_size_g']} g"
    end
    @response = final_results
    @meal_form = MealForm.new
    render :new
  end

  private

  def meal_form_params
    params.require(:meal_form).permit(:meal_date, :meal_period, :meal_type, :meal_memo,
                                      :meal_title_first, :meal_weight_first, :meal_calorie_first,
                                      :meal_title_second, :meal_weight_second, :meal_calorie_second,
                                      :meal_title_third, :meal_weight_third, :meal_calorie_third,
                                      meal_images: []).merge(user_id: current_user.id)
  end

  def meal_params
    params.require(:meal).permit(:meal_date, :meal_period, :meal_type, :meal_memo,
                                 :meal_title_first, :meal_weight_first, :meal_calorie_first,
                                 :meal_title_second, :meal_weight_second, :meal_calorie_second,
                                 :meal_title_third, :meal_weight_third, :meal_calorie_third,
                                 meal_images: []).merge(user_id: current_user.id, meal_id: params[:id])
  end

  def set_response
    @response ||= []
  end
end
