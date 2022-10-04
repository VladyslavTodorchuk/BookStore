class ApplicationController < ActionController::Base
  before_action :user_or_guest_have_order

  private

  def user_or_guest_have_order
    if current_user && (session[:order_id].nil? || Order.where(id: session[:order_id], user_id: current_user.id,
                                                               status: :initialized).empty?)
      session[:order_id] = Order.find_or_create_by(user_id: current_user.id, status: :initialized).id
      CartCleaner.set(wait: 3.week).perform_later(session[:order_id])
    elsif session[:order_id].nil? || Order.where(id: session[:order_id]).empty?
      session[:order_id] = Order.create.id
      CartCleaner.set(wait: 3.week).perform_later(session[:order_id])
    end
  end
end
