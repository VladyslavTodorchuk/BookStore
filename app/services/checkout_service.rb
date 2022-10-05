class CheckoutService
  def self.page_step(step)
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
end
