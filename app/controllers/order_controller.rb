class OrderController < ApplicationController
  def index
    @cart = Order.find(session[:order_id])
  end
end
