class ApplicationController < ActionController::Base
  before_action :user_or_guest_have_order, :save_previous_url

  private

  def user_or_guest_have_order
    if current_user && (session[:order_id].nil? || Order.where(id: session[:order_id], user_id: current_user.id,
                                                               status: :initialized).empty?)
      create_order_for_user
    elsif session[:order_id].nil? || Order.where(id: session[:order_id]).empty?
      create_order_for_guest
    end
  end

  def create_order_for_user
    session[:order_id] = Order.find_or_create_by(user_id: current_user.id, status: :initialized).id
    CartCleaner.perform_in(3.days, session[:order_id])
  end

  def create_order_for_guest
    session[:order_id] = Order.create.id
    CartCleaner.perform_in(3.days, session[:order_id])
  end

  def save_prev_url
    session[:save_prev_url] = request.url
  end
end
