class HomeController < ApplicationController
  def index
    @catalog = Book.order('created_at DESC').first(3)
    @best_sellers = best_sellers
  end

  private

  def best_sellers
    Book.first(4)
  end
end
