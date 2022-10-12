class OrdersController < ApplicationController
  after_action :update_order_last_action, only: [:update]
  def index
    @cart = Order.find(session[:order_id]).decorate
  end

  def show
    if current_user
      @order = Order.find_by(id: session[:order_id], user_id: current_user.id).decorate
      render 'orders/show'
    else
      redirect_to new_checkout_path
    end
  end

  def update
    order = Order.find(params[:id])

    if params[:order][:delivery_id]
      update_delivery_method(params[:order][:delivery_id], order)
    else
      params[:order][:address_id]
      update_address(params[:order][:address_id], order)
    end
  end

  private

  def update_order_last_action
    Order.find(session[:order_id]).update(last_action: DateTime.now)
  end

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
end
