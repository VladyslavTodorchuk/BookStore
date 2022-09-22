class CouponService
  def self.find_coupon(params, order, coupon)
    error_message = I18n.t('order.coupon.error')

    if coupon.nil?
      error_message = ' ' if params[:code].eql?('')

      {
        error: error_message,
        total_price: order.decorate.order_price / 100
      }
    else
      {
        total_price: order.decorate.order_price(coupon.discount) / 100,
        discount: (order.decorate.order_price * coupon.discount) / 100
      }
    end
  end
end
