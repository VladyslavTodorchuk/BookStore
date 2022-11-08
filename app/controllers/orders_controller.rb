class OrdersController < ApplicationController
  def index
    @cart = Order.find(session[:order_id]).decorate
  end

  def registration_without_password; end
end
