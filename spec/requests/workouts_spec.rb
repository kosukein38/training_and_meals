require 'rails_helper'

RSpec.describe "Workouts", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/workouts/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/workouts/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/workouts/create"
      expect(response).to have_http_status(:success)
    end
  end

end
