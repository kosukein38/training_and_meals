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
    deepl_api_key = Rails.application.credentials.deepl[:api_key]
    deepl_api_url = URI('https://api-free.deepl.com/v2/translate')
    req_params = {
      auth_key: deepl_api_key,
      text:,
      target_lang: 'EN',
      source_lang: 'JA'
    }
    response = Net::HTTP.post_form(deepl_api_url, req_params)
    result_body = JSON.parse(response.body)
    translated_text = result_body['translations'][0]['text']
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
    final_results
  end
end
