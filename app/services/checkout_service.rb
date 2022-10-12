class CheckoutService
  def self.to_errors(message)
    message.map do |k, v|
      "#{k} #{v.join(', ')}"
    end.join("\n")
  end

  def self.count_total_price(order)
    order_book = OrderBook.where(order_id: order.id)

    total_price = order_book.map do |product|
      product.book.price_cents * product.quantity
    end.sum

    total_price *= order.coupon.discount unless order.coupon.nil?

    total_price + order.delivery.price_cents
  end

  def self.check(attributes)
    attributes.each do |_k, v|
      return false if v.nil? || v.eql?('')
    end

    true
  end

  def self.check_fields(permitted_params)
    case permitted_params[:step]
    when 'shipping'
      check(permitted_params[:shipping]) unless permitted_params[:shipping].nil?
    when 'billing'
      check(permitted_params[:billing]) unless permitted_params[:billing].nil?
    when 'payment'
      check(permitted_params[:credit_card]) unless permitted_params[:credit_card].nil?
    else
      true
    end

    def update_step(step, params)
      case step
      when :address then update_address(params[:permitted_params], params[:user])
      when :payment then update_payment(params[:permitted_params], params[:user])
      when :confirm then update_confirm(params[:permitted_params])
      when :complete then update_complete(params[:permitted_params])
      end
    end

    def update_address(permitted_params, current_user)
      if permitted_params[:shipping].nil?
        BillingUpdate.call(permitted_params: permitted_params, current_user: current_user)
      else
        ShippingUpdate.call(permitted_params: permitted_params, current_user: current_user)
      end
    end

    def update_payment(permitted_params, current_user)
      CreditCardUpdate.call(permitted_params: permitted_params, current_user: current_user)
    end

    def update_confirm(permitted_params); end

    def update_complete(permitted_params); end
  end
end
