class HomeController < ApplicationController
  def index
    @catalog = BookDecorator.decorate_collection(Book.order(created_at: :desc).first(Constants::CATALOG_BOOK_COUNT))
    @best_sellers = BookDecorator.decorate_collection(BestSellersQuery.query)
  end
end
