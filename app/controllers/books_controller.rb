class BooksController < ApplicationController
  def index
    @books_count = Book.count
    @categories = Category.all

    @page = params[:page].nil? ? 1 : params[:page].to_i
    @books = BookQuery.query(params).limit(@page * ApplicationHelper::PAGINATION_PER_PAGE)
  end

  def show
    @book = Book.find_by(id: params[:id])

    redirect_to books_path if @book.nil?
  end
end
