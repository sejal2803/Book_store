require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST #create" do

    let!(:admin) { FactoryBot.create(:admin) }
    let(:valid_params) { { email: admin.email, password: admin.password } }
    let(:invalid_params) { { email: admin.email, password: "wrongpassword" } }

    context "when credentials are valid" do

      it "returns an authentication token" do
        post :create, params: valid_params
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to include("token")
      end
    end

    context "when credentials are invalid" do

      it "returns an error message" do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.body).to include("error")
      end
    end
  end
end
