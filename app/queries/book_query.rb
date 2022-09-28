class BookQuery
  SORT_METHODS = ['created_at', 'created_at DESC', 'price_cents DESC', 'most_popular', 'price_cents', 'title',
                  'title DESC'].freeze
  def self.query(params)
    if SORT_METHODS.include?(params[:sort].to_s)
      if params[:category].nil?
        Book.order(params[:sort])
      else
        Book.joins(:books_categories).where(books_categories: { category_id: params[:category] }).order(params[:sort])
      end
    elsif params[:category].nil?
      Book.all
    else
      Book.joins(:books_categories).where(books_categories: { category_id: params[:category] })
    end
  end
end