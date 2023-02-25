class DeeplApiService
  def initialize(text)
    @text = text
  end

  def call
    translating_japanese_to_english
  end

  private

  attr_reader :text

  def translating_japanese_to_english
    connection = Faraday.new('https://api-free.deepl.com') do |builder|
      builder.request  :url_encoded
      builder.response :json, content_type: /\bjson$/
      builder.adapter  :net_http
    end
    params = {
      text:,
      auth_key: Rails.application.credentials.deepl[:api_key],
      target_lang: 'EN',
      source_lang: 'JA'
    }
    deepl_response = connection.post('/v2/translate', params)
    deepl_response.body['translations'][0]['text']
  end
end
