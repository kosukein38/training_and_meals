class NutritionApiService
  def initialize(text)
    @text = text
  end

  def call
    taking_nutrition_info
  end

  private

  attr_reader :text

  def taking_nutrition_info
    connection = Faraday.new('https://nutrition-by-api-ninjas.p.rapidapi.com') do |builder|
      builder.request  :url_encoded
      builder.response :json, content_type: /\bjson$/
      builder.adapter  :net_http
    end

    params = {
      query: text
    }
    headers = {
      'X-RapidAPI-Key' => Rails.application.credentials.nutrition[:api_key].to_s,
      'X-RapidAPI-Host' => connection.url_prefix.host.to_s
    }
    nutrition_response = connection.get('v1/nutrition', params, headers)
    nutrition_response_body = nutrition_response.body
    format_json_data(nutrition_response_body)
  end

  def format_json_data(nutrition_response_body)
    results = []
    nutrition_response_body.each do |result|
      results << "メニュー：#{result['name']} カロリー：#{result['calories']} kcal グラム数：#{result['serving_size_g']} g"
    end
    results << 'すみません...見つかりませんでした' if results.empty?
    results
  end
end
