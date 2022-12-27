require 'rails_helper'

RSpec.describe 'Meals' do
  describe 'GET /new' do
    xit 'returns http success' do
      get '/meals/new'
      expect(response).to have_http_status(:success)
    end
  end
end
