class BooksController < ApplicationController
  def index
    @books_count = Book.count
    @categories = Category.all

    @page = params.fetch(:page, 1).to_i
    @books = BookQuery.query(params).limit(@page * ApplicationHelper::PAGINATION_PER_PAGE)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @book = Book.find_by(id: params[:id])

    redirect_to books_path if @book.nil?
  end
end
