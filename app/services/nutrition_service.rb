require 'uri'
require 'net/http'
require 'openssl'

class NutritionService
  def initialize(text)
    @text = text
  end

  def call
    get_nutrition_info
  end

  private

  attr_reader :text

  def get_nutrition_info
    nutrition_api_uri = URI.parse("https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?query=#{text}")
    nutrition_api_key = Rails.application.credentials.nutrition[:api_key]
    headers = {
      'X-RapidAPI-Key' => nutrition_api_key,
      'X-RapidAPI-Host' => nutrition_api_uri.host
    }
    http = Net::HTTP.new(nutrition_api_uri.host, nutrition_api_uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    nutrition_response = http.get(nutrition_api_uri, headers)
    nutrition_response_body = JSON.parse(nutrition_response.body)
    # resultsに結果を入れて返す
    results = []
    nutrition_response_body.each do |result|
      results << "メニュー：#{result['name']} カロリー：#{result['calories']} kcal グラム数：#{result['serving_size_g']} g"
    end
    results
  end
end
