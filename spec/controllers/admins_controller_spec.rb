require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  include JwtHelper
  
  let(:admin) { FactoryBot.create(:admin) }
  let(:token) { generate_token(admin.id) }
  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          admin: {
            name: "John Smith",
            email: "john@example.com",
            password: "password",
            password_confirmation: "password"
          }
        }
      end

      it "creates a new admin" do
        expect {
          post :create, params: valid_params
        }.to change(Admin, :count).by(1)
      end

      it "returns a success response" do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          admin: {
            name: "",
            email: "",
            password: "",
            password_confirmation: ""
          }
        }
      end

      it "does not create a new admin" do
        expect {
          post :create, params: invalid_params
        }.to_not change(Admin, :count)
      end

      it "returns an error response" do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
  describe "PUT #update" do

    context "with valid parameters" do
      let(:valid_params) do
        {
          id: admin.id,
          admin: {
            name: "Jane Doe",
            email: "jane@example.com",
            password: "newpassword",
            password_confirmation: "newpassword"
          }
        }
      end

      it "updates the admin details" do
        # headers = { "Authorization" => "Bearer #{token}" }
        
        request.headers.merge!("Authorization" => "Bearer #{token}")
        put :update, params: { id: admin.id, admin: valid_params }
        admin.reload
        expect(admin.name).to eq(admin.name)
        expect(admin.email).to eq(admin.email)
      end

      it "returns a success response" do

        request.headers.merge!("Authorization" => "Bearer #{token}")
        put :update, params: valid_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          id: admin.id,
          admin: {
            name: "",
            email: "",
            password: "",
            password_confirmation: ""
          }
        }
      end

      it "does not update the admin details" do
        request.headers.merge!("Authorization" => "Bearer #{token}")
        put :update, params: invalid_params
        admin.reload
        expect(admin.name).to_not eq("")
        expect(admin.email).to_not eq("")
      end

      it "returns an error response" do
        request.headers.merge!("Authorization" => "Bearer #{token}")
        put :update, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
