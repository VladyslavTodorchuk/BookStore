class DeliveryDecorator < Draper::Decorator
  delegate_all

  def price
    Money.new(price_cents)
  end
end
