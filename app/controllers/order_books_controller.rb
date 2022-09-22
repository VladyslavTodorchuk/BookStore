class OrderBooksController < ApplicationController
  def add_to_order
    product = OrderBook.new(order_id: params[:order_id], book_id: params[:book_id], quantity: params[:quantity])

    respond_to do |format|
      format.html
      format.json do
        if product.save
          render json: { notice: 'Added!' }
        else
          render json: { notice: 'Error!' }
        end
      end
    end
  end

  def delete_product
    product = OrderBook.find_by(order_id: params[:order_id], book_id: params[:book_id])

    if product.destroy
      redirect_to orders_path, notice: I18n.t('order.messages.delete')
    else
      redirect_to orders_path, alert: I18n.t('order.errors.error_delete')
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
end
