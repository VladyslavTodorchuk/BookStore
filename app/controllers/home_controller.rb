class HomeController < ApplicationController
  def index
    @top_book = Book.first(3)
    @catalog = Book.order('created_at DESC').first(3)
  end
end
