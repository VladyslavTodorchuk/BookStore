
class BooksController < ApplicationController
  def index
    @books = Book.order(:title).first(8)
    @categories = Category.all
  end

  def show
    @book = Book.find_by(id: params[:id])

    if @book == nil
      redirect_to books_path
    end
  end
end