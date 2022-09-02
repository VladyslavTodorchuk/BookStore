class BooksController < ApplicationController
  def index
    @books_count = Book.count
    @categories = Category.all

    @books = BookQuery.query(params).paginate(page: params[:page], per_page: 4)

    respond_to do |format|
      format.html
      format.json do
        render json: {
          entries: render_to_string(partial: 'books',
                                    formats: [:html],
                                    pagination: view_context.will_paginate(@books))
        }
      end
    end
  end

  def show
    @book = Book.find_by(id: params[:id])

    redirect_to books_path if @book.nil?
  end
end
