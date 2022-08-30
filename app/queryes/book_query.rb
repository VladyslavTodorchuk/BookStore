class BookQuery
  def self.query(params)
    if ApplicationHelper::SORT_METHODS.include?(params[:sort].to_s)
      return Book.all.order(params[:sort]) if params[:category].nil?
      return Category.find(params[:category]).books.order(params[:sort]) unless params[:category].nil?
    end
    params[:category].nil? ? Book.all : Category.find(params[:category]).books
  end
end
