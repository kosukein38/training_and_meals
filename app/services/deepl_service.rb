require 'uri'
require 'net/http'
require 'openssl'

class DeeplService
  def initialize(text)
    @text = text
  end

  def call
    translating_japanese_to_english
  end

  private

  attr_reader :text

  def translating_japanese_to_english
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
    return translated_text = deepl_response_body['translations'][0]['text']
  end
end
