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
    book = Book.find_by(id: params[:id])
    redirect_to books_path if book.nil?

    @book = book.decorate
<<<<<<< HEAD
    @reviews = @book.reviews.where(verified: true).order(created_at: :desc)
=======
    @reviews = ReviewDecorator.decorate_collection(Review.where(book_id: book.id,
                                                                verified: true).order(created_at: :desc))
>>>>>>> 0b8c75a (Rebase)
  end
end
