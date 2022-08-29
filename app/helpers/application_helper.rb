module ApplicationHelper
  def price_calculation(price)
    price * params[:item_amount].nil? ? 1 : params[:item_amount]
  end
end
