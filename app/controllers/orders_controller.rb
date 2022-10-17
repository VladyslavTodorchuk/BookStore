require_relative '../queries/order_query'
class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[update index]
  def show
    @cart = Order.find(session[:order_id]).decorate
  end

  def index
    @orders = OrderQuery.query(params, current_user)
  end

  def update
    order = Order.find(params[:id])

    if params[:order][:delivery_id]
      update_delivery_method(params[:order][:delivery_id], order)
    elsif params[:order][:address_id]
      update_address(params[:order][:address_id], order)
    elsif params[:order][:billing] || params[:order][:shipping]
      update_user_address(params[:order])
    end
  end

  private

  def update_delivery_method(delivery_id, order)
    method = Delivery.find(delivery_id)

    redirect_to checkout_path(step: :delivery), alert: 'No method found!' if order.nil? && method.nil?

    if order.update(delivery_id: method.id)
      redirect_to checkout_path(step: :payment)
    else
      redirect_to checkout_path(step: :delivery)
    end
  end

  def update_address(address_id, order)
    address = Address.find(address_id)

    redirect_to checkout_path(step: :address), alert: 'No address found!' if order.nil? && address.nil?

    if order.update(address_id: address.id)
      redirect_to checkout_path(step: :delivery)
    else
      redirect_to checkout_path(step: :address)
    end
  end

  def update_user_address(permitted_params)
    if permitted_params[:shipping].nil?
      current_user.billing.update(permitted_params[:billing])
    else
      current_user.shipping.update(permitted_params[:shipping])
    end

    redirect_to checkout_path(step: :address)
  end
end
