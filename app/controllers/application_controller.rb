class ApplicationController < ActionController::Base
  before_action :have_order

  private
  def have_order
    @cart = Order.find_or_create_by(user_id: current_user.id) if current_user

    @cart = Order.find(session[:order_id]) unless session[:order_id].nil?

    @cart = Order.create if session[:order_id].nil?
  end
end
