class OrderService
  attr_reader :step, :message

  def update_delivery_method(delivery_id, order, session)
    method = Delivery.find(delivery_id)

    if order.nil? && method.nil?
      @step = :delivery
      @message = { alert: I18n.t('orders.messages.error.no_method') }
    end

    if order.update(delivery_id: method.id)
      @step = if session[:previous_path].split('=').last.eql?('confirm')
                :confirm
              else
                :payment
              end
      @message = { notice: I18n.t('orders.messages.success.method') }
    else
      @step = :delivery
    end
  end

  def update_address(address_id, order)
    address = Address.find(address_id)

    if order.nil? && address.nil?
      @step = :address
      @message = { alert: 'No address found!' }
    end

    @step = if order.update(address_id: address.id)
              :delivery
            else
              :address
            end
    @message = { notice: "#{address.type.capitalize} was picked" }
  end
end
