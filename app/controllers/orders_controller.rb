class OrdersController < ApplicationController
  def index
    @cart = Order.find(session[:order_id]).decorate
  end

  def show
    if current_user
      @order = Order.find_by(id: session[:order_id], user_id: current_user.id).decorate
      render 'orders/show'
    else
      redirect_to new_checkout_path
    end
  end
end
