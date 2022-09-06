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
    book = Book.find_by(id: params[:id])
=======
    @book = BookDecorator.decorate(Book.find(params[:id]))
>>>>>>> bd8bda4 (Manifest_cache true)

    if book.nil?
      redirect_to books_path
    else
      @book = book.decorate
    end
  end
end
