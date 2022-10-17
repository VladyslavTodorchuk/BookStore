class ApplicationController < ActionController::Base
  before_action :user_or_guest_have_order
  after_action :save_previous_path

  private

  def user_or_guest_have_order
<<<<<<< HEAD
    if current_user && (session[:order_id].nil? || Order.where(id: session[:order_id], user_id: current_user.id,
                                                               status: :initialized).empty?)
=======
    if current_user && (session[:order_id].nil? || Order.where(id: session[:order_id]).empty?)
>>>>>>> 25f3c50 (Add sort orders)
      create_order_for_user
    elsif session[:order_id].nil? || Order.where(id: session[:order_id]).empty?
      create_order_for_guest
    end
  end

  def create_order_for_user
    session[:order_id] = Order.find_or_create_by(user_id: current_user.id, status: :initialized).id
<<<<<<< HEAD
    CartCleaner.perform_in(3.days, session[:order_id])
=======
    CartCleanerJob.perform_in(3.days, session[:order_id])
>>>>>>> 25f3c50 (Add sort orders)
  end

  def create_order_for_guest
    session[:order_id] = Order.create.id
<<<<<<< HEAD
    CartCleaner.perform_in(3.days, session[:order_id])
  end

  def save_prev_url
    session[:save_prev_url] = request.url
=======
    CartCleanerJob.perform_in(3.days, session[:order_id])
  end

  def save_previous_path
    previous_path = request.path
    session[:previous_path] = previous_path unless previous_path == request.url
>>>>>>> 25f3c50 (Add sort orders)
  end
end
