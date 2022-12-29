require 'uri'
require 'net/http'
require 'openssl'

class ApiController < ApplicationController
  before_action :set_user, only: %i[result]

  def result
    text = params[:api_text]
    #APIキーを定義
    deepl_api_key = Rails.application.credentials.deepl[:api_key]
    #リクエストURLを定義
    deepl_api_url = URI("https://api-free.deepl.com/v2/translate")
    #リクエストパラメーターを定義
    req_params = {
      auth_key: deepl_api_key,
      text: text,
      target_lang: "EN",
      source_lang: "JA"
    }
    #リクエストを送信し、返ってきたレスポンスを変数responseに格納
    response = Net::HTTP.post_form(deepl_api_url, req_params)
    result = JSON.parse(response.body)
    translated_text = result["translations"][0]["text"]
    #translated_textをクエリに含ませ、Nutrition by API-NinjasのAPIを叩く
    nutrition_url = URI("https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?query=#{translated_text}")

    http = Net::HTTP.new(nutrition_url.host, nutrition_url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(nutrition_url)
    request["X-RapidAPI-Key"] = Rails.application.credentials.nutrition[:api_key]
    request["X-RapidAPI-Host"] = 'nutrition-by-api-ninjas.p.rapidapi.com'

    response = http.request(request)
    results = JSON.parse(response.body)
    final_results = []
    results.each do |result|
      final_results << "メニュー：#{result["name"]}"
      final_results << "カロリー：#{result["calories"]}"
      final_results << "グラム数：#{result["serving_size_g"]}"
    end
    @response = final_results
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end
end
