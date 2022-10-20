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
    when 'address'
      check(permitted_params[:shipping]) unless permitted_params[:shipping].nil?

      check(permitted_params[:billing]) unless permitted_params[:billing].nil?
    when 'payment'
      check(permitted_params[:credit_card]) unless permitted_params[:credit_card].nil?
    else
      true
    end
  end
end
