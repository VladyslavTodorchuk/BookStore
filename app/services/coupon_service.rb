class CouponService
  def self.find_coupon(params, order, coupon)
    error_message = I18n.t('order.coupon.error')

    if coupon.nil?
      error_message = ' ' if params[:code].eql?('')
      { error: error_message, total_price: order.decorate.order_price.to_s }
    elsif !coupon.is_active
      error_message = ' ' if params[:code].eql?('')

      { error: error_message, total_price: order.decorate.order_price.to_s }
    else
      coupon&.update(order_id: order.id)

      { total_price: order.decorate.order_price(coupon.discount).to_s,
        discount: (order.decorate.order_price * coupon.discount).to_s }
    end
  end
end
