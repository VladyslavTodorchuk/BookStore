class BookQuery
  def self.query(params)
    if ApplicationHelper::SORT_METHODS.include?(params[:sort].to_s)
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
