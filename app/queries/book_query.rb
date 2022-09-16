class BookQuery
  SORT_METHODS = ['created_at', 'created_at DESC', 'price_cents DESC', 'most_popular', 'price_cents', 'title', 'title DESC'].freeze

  def self.query(params)
    if SORT_METHODS.include?(params[:sort].to_s)
      if params[:category].nil?
        Book.all.order(params[:sort])
      else
        Category.find(params[:category]).books.order(params[:sort])
      end
    else
      params[:category].nil? ? Book.all : Category.find(params[:category]).books
    end
  end
end
