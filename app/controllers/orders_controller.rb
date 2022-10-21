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

    if params[:order].nil?
      redirect_to checkout_path(step: :delivery), alert: t('orders.messages.error.pick')
    elsif params[:order][:delivery_id]
      update_delivery_method(params[:order][:delivery_id], order)
    elsif params[:order][:address_id]
      update_address(params[:order][:address_id], order)
    end
  end

  private

  def update_delivery_method(delivery_id, order)
    method = Delivery.find(delivery_id)

    redirect_to checkout_path(step: :delivery), alert: t('orders.messages.error.no_method') if order.nil? && method.nil?

    if order.update(delivery_id: method.id)
      if session[:previous_path].split('=').last.eql?('confirm')
        redirect_to checkout_path(step: :confirm), notice: t('orders.messages.success.method')
      else
        redirect_to checkout_path(step: :payment), notice: t('orders.messages.success.method')
      end
    else
      redirect_to checkout_path(step: :delivery)
    end
  end

  def update_address(address_id, order)
    address = Address.find(address_id)

    redirect_to checkout_path(step: :address), alert: 'No address found!' if order.nil? && address.nil?

    if order.update(address_id: address.id)
      redirect_to checkout_path(step: :delivery), notice: "#{address.type.capitalize} was picked"
    else
      redirect_to checkout_path(step: :address), notice: "#{address.type.capitalize} was picked"
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
