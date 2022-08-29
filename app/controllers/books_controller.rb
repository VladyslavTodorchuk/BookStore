class BooksController < ApplicationController
  def index
    @books = Book.order(:title).first(8)
    @categories = Category.all
  end

  def show
    @book = Book.find_by(id: params[:id])

    redirect_to books_path if @book.nil?
  end
end
