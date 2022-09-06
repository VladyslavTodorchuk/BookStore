class HomeController < ApplicationController
  def index
    @catalog = BookDecorator.decorate_collection(Book.order('created_at DESC').first(3))
    @best_sellers = best_sellers
  end

  private

  def best_sellers
    BookDecorator.decorate_collection(Book.first(4))
  end
end
