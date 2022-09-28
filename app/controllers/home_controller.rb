class HomeController < ApplicationController
  def index
    @catalog = BookDecorator.decorate_collection(Book.order(created_at: :desc).first(Constants::CATALOG_BOOK_COUNT))
    @best_sellers = best_sellers
  end

  private

  def best_sellers
    BookDecorator.decorate_collection(Book.first(Constants::BEST_SELLER_COUNT))
  end
end