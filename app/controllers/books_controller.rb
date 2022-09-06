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
          entries: render_to_string(partial: 'books', formats: [:html]),
          pagination: view_context.will_paginate(@books)
        }
      end
    end
  end

  def show
<<<<<<< HEAD
    book = Book.find(params[:id])
=======
<<<<<<< HEAD
    book = Book.find_by(id: params[:id])
=======
    @book = BookDecorator.decorate(Book.find(params[:id]))
>>>>>>> aa7b40c (Manifest_cache true)
>>>>>>> 7bc7f9f (Manifest_cache true)

    redirect_to books_path if book.nil?

    @book = book.decorate
    @reviews = @book.reviews.where(verified: true).order(created_at: :desc)
  end
end
