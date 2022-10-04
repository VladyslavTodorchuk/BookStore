class OrdersController < ApplicationController
  # skip_before_action :authenticate_user!, only: :edit
  def index
    @cart = Order.find(session[:order_id]).decorate
  end

  def show
    @order = Order.find_by(id: session[:order_id], user_id: current_user.id).decorate
    @user_billing = Billing.find_or_create_by(user_id: current_user.id)
    @user_shipping = Shipping.find_or_create_by(user_id: current_user.id)
  end
end
