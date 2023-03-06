require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  include JwtHelper
  
  let(:admin) { FactoryBot.create(:admin) }
  let(:token) { generate_token(admin.id) }

  describe "GET #index" do

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    let(:book) { FactoryBot.create(:book) }

    it "returns http success" do
      get :show, params: { id: book.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:book_params) { FactoryBot.attributes_for(:book) }
  
    it "creates a new book" do
      request.headers.merge!("Authorization" => "Bearer #{token}")
      expect {
        post :create, params: { book: book_params }
      }.to change(Book, :count).by(1)
    end
  
    it "redirects to the new book" do
      request.headers.merge!("Authorization" => "Bearer #{token}")
      post :create, params: { book: book_params }
      expect(response).to have_http_status(:created)
      expect(response.body).to include("The Great Gatsby")
      expect(response.body).to include("F. Scott Fitzgerald")
      expect(response.body).to include("9.99")
      expect(response.body).to include("-147451")
      expect(response.body).to include("25")
    end
  end

  describe "PATCH #update" do
    let(:book) { FactoryBot.create(:book) }
  
    context "with valid parameters" do
      it "updates the book and returns success message" do
        request.headers.merge!("Authorization" => "Bearer #{token}")
        patch :update, params: { id: book.id, book: { name: "New Name", author: "New Author", price: 10.99 } }
        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to include("Book updated successfully")
      end
    end
  
    context "with invalid parameters" do
      it "returns unprocessable entity and error messages" do
        request.headers.merge!("Authorization" => "Bearer #{token}")
        patch :update, params: { id: book.id, book: { name: "", author: "", price: "invalid" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response.body).to include("{\"name\":[\"can't be blank\"],\"price\":[\"is not a number\"],\"author\":[\"can't be blank\"]}")
        expect(response.body).to include("{\"name\":[\"can't be blank\"],\"price\":[\"is not a number\"],\"author\":[\"can't be blank\"]}")
        expect(response.body).to include("{\"name\":[\"can't be blank\"],\"price\":[\"is not a number\"],\"author\":[\"can't be blank\"]}")
      end
    end

    describe "DELETE #destroy" do
      let(:book) { FactoryBot.create(:book) }
    
      it "deletes the book and returns success message" do
        request.headers.merge!("Authorization" => "Bearer #{token}")
        delete :destroy, params: { id: book.id }
        expect(response).to have_http_status(:success)
        expect(response.content_type).to include("application/json")
        expect(response.body).to include("Book deleted successfully")
      end
    
      it "deletes the book from the database" do
        request.headers.merge!("Authorization" => "Bearer #{token}")
        expect { delete :destroy, params: { id: book.id } }.to change(Book, :count).by(0)
      end
    end
  end
end
