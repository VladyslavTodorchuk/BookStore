require_relative '../services/coupon_service'
require_relative '../services/book_service'

class OrderBooksController < ApplicationController
  before_action :update_order_last_action
  def add_to_order
    product = OrderBook.new(order_id: params[:order_id], book_id: params[:book_id], quantity: params[:quantity])

    respond_to do |format|
      format.json do
        product.save if OrderBook.where(order_id: params[:order_id], book_id: params[:book_id]).empty?

        render json: { count: OrderBook.where(order_id: product.order.id).count }
      end
    end
  end

  def delete_product
    product = OrderBook.find_by(order_id: params[:order_id], book_id: params[:book_id])

    if product.destroy
      redirect_to order_path(session[:order_id]), notice: I18n.t('orders.messages.error.delete')
    else
      redirect_to order_path(session[:order_id]), alert: I18n.t('orders.messages.error.error_delete')
    end
  end

  def update_quantity
    product = OrderBook.find_by(order_id: params[:order_id], book_id: params[:book_id])
    book = Book.find(params[:book_id])
    order = Order.find(params[:order_id])
    coupon = Coupon.find_by(code: params[:code])

    respond_to do |format|
      format.html
      format.json do
        render json: BookService.quantity_update(params, product, order, book, coupon)
      end
    end
  end

  def update
    product = OrderBook.find_by(order_id: session[:order_id], book_id: params[:book_id])

    product.update(quantity: params[:quantity])

    redirect_to orders_path
  end

  private

  def order_item_params
    params.permit(%i[book_id quantity order_id])
  end

  def update_order_last_action
    Order.find(session[:order_id]).update(updated_at: DateTime.now)
  end
end
