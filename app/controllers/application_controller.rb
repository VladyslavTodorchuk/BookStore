class ApplicationController < ActionController::Base
  before_action :user_or_guest_have_order
  after_action :save_previous_path

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
    CartCleanerJob.perform_in(3.days, session[:order_id])
  end

  def create_order_for_guest
    session[:order_id] = Order.create.id
    CartCleanerJob.perform_in(3.days, session[:order_id])
  end

  def save_previous_path
    previous_path = request.path
    session[:previous_path] = previous_path unless previous_path == request.url
  end
end
