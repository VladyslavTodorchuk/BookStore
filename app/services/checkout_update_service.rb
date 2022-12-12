class CheckoutUpdateService
  attr_reader :checkout

  def initialize(checkout)
    @checkout = checkout
  end

  def update_shipping(permitted_params, user_shipping)
    return if permitted_params[:shipping].nil?

    if user_shipping.update(permitted_params[:shipping])
      { notice: 'Shipping was updated' }
    else
      { alert: checkout.to_errors(user_shipping.errors.messages) }
    end
  end

  def update_billing(permitted_params, user_billing)
    return if permitted_params[:billing].nil?

    if user_billing.update(permitted_params[:billing])
      { notice: 'Billing was updated' }
    else
      { alert: checkout.to_errors(user_billing.errors.messages) }
    end
  end

  def update_payment(permitted_params, credit_card)
    if credit_card.update(permitted_params[:credit_card])
      { step: :confirm, message: { notice: 'Credit Card was updated' } }
    else
      { step: :payment, message: { alert: checkout.to_errors(credit_card.errors.messages) } }
    end
  end

  def update_complete(order)
    order.coupon&.update(is_active: false)

    if order.update(status: :created, total_price: checkout.count_total_price(order))
      { message: { notice: I18n.t('orders.messages.success.order') } }
    else
      { step: :confirm, message: { alert: I18n.t('orders.messages.error.something_went_wrong') } }
    end
  end
end
