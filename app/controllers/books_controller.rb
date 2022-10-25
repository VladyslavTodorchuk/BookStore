class BooksController < ApplicationController
  def index
    @books_count = Book.count
    @categories = Category.all
    sorted_books = BookQuery.query(params).paginate(page: params[:page],
                                                    per_page: Constants::PAGINATION_PER_PAGE)

    @books = BookDecorator.decorate_collection(sorted_books)

    respond_to do |format|
      format.html
      format.json do
        render json: {
          entries: render_to_string(partial: 'books/index/books', formats: [:html]),
          pagination: view_context.will_paginate(@books)
        }
      end
    end
  end

  def show
    book = Book.find(params[:id])

    redirect_to books_path if book.nil?

    @book = book.decorate
    @reviews = @book.reviews.where(verified: true).order(created_at: :desc)
  end
end
