require_relative '../services/coupon_service'

class CouponsController < ApplicationController
  def find
    coupon = Coupon.find_by(code: params[:code])
    order = Order.find(session[:order_id])

    coupon&.update(order_id: order.id)

    respond_to do |format|
      format.json do
        render json: CouponService.find_coupon(params, order, coupon)
      end
    end
  end
end
