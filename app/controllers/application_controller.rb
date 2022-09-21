class ApplicationController < ActionController::Base
  before_action :user_or_guest_have_order

  private

  def user_or_guest_have_order
    session[:order_id] = Order.find_or_create_by(user_id: current_user.id).id if current_user

    session[:order_id] = Order.create.id if session[:order_id].nil?
  end
end
