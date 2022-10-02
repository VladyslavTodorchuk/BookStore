class ApplicationController < ActionController::Base
  before_action :user_or_guest_have_order

  private

  def user_or_guest_have_order
    if current_user
      session[:order_id] = Order.find_or_create_by(user_id: current_user.id).id
      CartCleaner.set(wait: 1.week).perform_later(session[:order_id])
    elsif session[:order_id].nil?
      session[:order_id] = Order.create.id
      CartCleaner.set(wait: 1.week).perform_later(session[:order_id])
    end
  end
end
