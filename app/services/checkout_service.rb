class CheckoutService
  class << self
    def page_step(step)
      case step
      when :initialize then 'checkouts/new'
      when :delivery then 'checkouts/delivery'
      when :address then 'checkouts/address'
      when :payment then 'checkouts/payment'
      when :confirm then 'checkouts/confirm'
      when :complete then 'checkouts/complete'
      else 'checkouts/address'
      end
    end

    def update_step(step, params)
      case step
      when :address then update_address(params[:permitted_params], params[:user])
      when :payment then update_payment(params[:permitted_params], params[:credit_card])
      when :confirm then update_confirm(params[:permitted_params])
      when :complete then update_complete(params[:permitted_params])
      end
    end

    def all_fields_are_required(step, params)
      case step
      when :payment then check_fields(params[:credit_card])
      when :address then check_fields(params)
      else
        true
      end
    end

    def check_fields(params)
      params.each do |_k, v|
        return false if v.eql?('')
      end

      true
    end

    def update_address(permitted_params, current_user)
      if permitted_params[:shipping].nil?
        BillingUpdate.call(permitted_params: permitted_params, current_user: current_user)
      else
        ShippingUpdate.call(permitted_params: permitted_params, current_user: current_user)
      end
    end

    def update_payment(permitted_params, credit_card)
      CreditCardUpdate.call(permitted_params: permitted_params, credit_card: credit_card)
    end

    def update_confirm(permitted_params); end

    def update_complete(permitted_params); end


  end
end
