class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  # GET /books
  # List all books with pagination
  def index
    page = params[:page] || 1
    per_page = params[:per_page] || 30

    books = Book.select(:name, :ISBN, :quantity_available).paginate(page: page, per_page: per_page)

    books_data = books.map do |book|
      {
        name: book.name,
        ISBN: book.ISBN,
        in_stock: book.quantity_available > 0
      }
    end

    render json: {
      books: books_data,
      current_page: books.current_page,
      total_pages: books.total_pages
    }
  end

  # GET /books/1
  # Get details of a specific book
  def show
    render json: @book
  end

  # POST /books
  # Create a new book
  def create
    book = Book.new(book_params)
    if book.save
      render json: book, status: :created
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  # Update details of a specific book
  def update
    if @book.update(book_params)
      render json: { message: 'Book updated successfully' }
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  # Delete a specific book
  def destroy
    @book.destroy
    render json: { message: 'Book deleted successfully' }
  end

  private

  # Use a private method to set the @book instance variable
  # This is used by the show, update and destroy actions
  def set_book
    @book = Book.find(params[:id])
  end

  # Permitted parameters for the create and update actions
  def book_params
    params.require(:book).permit(:name, :author, :price, :ISBN, :quantity_available)
  end
end
