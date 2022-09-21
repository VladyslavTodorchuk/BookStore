class OrderBookController < ApplicationController
  def add_to_order
    product = OrderBook.new(order_id: params[:order_id], book_id: params[:book_id], quantity: params[:quantity])

    respond_to do |format|
      format.html
      format.json do
        if product.save
          render json: {
            notice: 'Added!'
          }
        else
          render json: {
            notice: 'Error!'
          }
        end
      end
    end
  end

  def delete_product
    product = OrderBook.find(order_id: params[:order_id], book_id: params[:book_id], quantity: params[:quantity])

    respond_to do |format|
      format.html
      format.json do
        if product.destroy
          render json: {
            notice: 'destroyed!'
          }
        else
          render json: {
            notice: 'Error!'
          }
        end
      end
    end
  end

  private

  def order_item_params
    params.permit(%i[book_id quantity order_id])
  end
end
