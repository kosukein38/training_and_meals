require 'uri'
require 'net/http'
require 'openssl'

class MealSearchService
  def initialize(text)
    @text = text
  end

  def call
    search_meal
  end

  private

  attr_reader :text

  def search_meal
    # Deepl APIで日本語入力を英語に
    deepl_api_uri = URI.parse('https://api-free.deepl.com/v2/translate')
    deepl_api_key = Rails.application.credentials.deepl[:api_key]
    req_params = {
      auth_key: deepl_api_key,
      text:,
      target_lang: 'EN',
      source_lang: 'JA'
    }
    deepl_response = Net::HTTP.post_form(deepl_api_uri, req_params)
    deepl_response_body = JSON.parse(deepl_response.body)
    translated_text = deepl_response_body['translations'][0]['text']
    # 英語に翻訳された'translated_text'をNutrition by API-Ninjas APIに渡して、カロリーを取得
    nutrition_api_uri = URI.parse("https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?query=#{translated_text}")
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
