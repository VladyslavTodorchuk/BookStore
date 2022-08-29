class BooksController < ApplicationController
  def index
    @books_count = Book.count
    @books = params[:category] ? Category.find(params[:category]).books : Book.all.order(:title)

    @catalog = Book.order(:created_at).first(3)
    @categories = Category.all
  end

  def show
    @book = Book.find_by(id: params[:id])

    redirect_to books_path if @book.nil?
  end
end
