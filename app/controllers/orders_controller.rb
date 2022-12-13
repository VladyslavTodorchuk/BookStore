require_relative '../queries/order_query'
require_relative '../services/order_service'
class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[update index]
  def show
    @cart = Order.find(session[:order_id]).decorate
  end

  def index
    @orders = OrderQuery.query(params, current_user)
  end

  def update
    order_service = OrderService.new
    order = Order.find(params[:id])

    if params[:order].nil?
      redirect_to checkout_path(step: :delivery), alert: I18n.t('orders.messages.error.pick')
    elsif params[:order][:delivery_id]
      order_service.update_delivery_method(params[:order][:delivery_id],
                                           order,
                                           session)
      form_redirect order_service
    elsif params[:order][:address_id]
      order_service.update_address(params[:order][:address_id], order)
      form_redirect order_service
    end
  end

  private

  def form_redirect(result)
    redirect_to checkout_path(step: result.step), result.message
  end
end
