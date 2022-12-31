require 'uri'
require 'net/http'
require 'openssl'

class MealsController < ApplicationController
  before_action :set_user, only: %i[new create show edit update destroy calorie_search]
  before_action :set_meal, only: %i[show edit destroy]
  before_action :set_response, only: %i[new edit]

  def show; end

  def new
    @meal_form = MealForm.new
  end

  def edit
    @meal_form = Meal.find(params[:id])
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

  def update
    @meal_form = MealForm.new(meal_params)

    if @meal_form.update
      redirect_to user_path(@user.id), success: t('defaults.message.updated', item: Meal.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Meal.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meal.destroy!
    redirect_to user_path(@user.id), success: t('defaults.message.deleted', item: Meal.model_name.human)
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
    params.require(:meal_form).permit(:meal_period, :meal_type, :meal_memo,
                                      :meal_title_first, :meal_weight_first, :meal_calorie_first,
                                      :meal_title_second, :meal_weight_second, :meal_calorie_second,
                                      :meal_title_third, :meal_weight_third, :meal_calorie_third).merge(user_id: current_user.id)
  end

  def meal_params
    params.require(:meal).permit(:meal_period, :meal_type, :meal_memo,
                                 :meal_title_first, :meal_weight_first, :meal_calorie_first,
                                 :meal_title_second, :meal_weight_second, :meal_calorie_second,
                                 :meal_title_third, :meal_weight_third, :meal_calorie_third).merge(user_id: current_user.id, meal_id: params[:id])
  end

  def set_user
    @user = User.find(current_user.id)
  end

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def set_response
    @response ||= []
  end
end
