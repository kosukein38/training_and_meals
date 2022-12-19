require 'rails_helper'

RSpec.describe "Workouts", type: :request do
  describe "GET /show" do
    xit "returns http success" do
      get "/workouts/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    xit "returns http success" do
      get "/workouts/new"
      expect(response).to have_http_status(:success)
    end
  end
end
