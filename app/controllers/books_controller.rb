class BooksController < ApplicationController
  def index
    @books_count = Book.count
    @catalog = Book.order(:created_at).first(3)
    @categories = Category.all

    @book = BookQuery.query(params)
  end

  def show
    @book = Book.find_by(id: params[:id])

    redirect_to books_path if @book.nil?
  end
end
