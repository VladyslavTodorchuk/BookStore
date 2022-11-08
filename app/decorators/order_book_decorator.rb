require 'monetize'

class OrderBookDecorator < Draper::Decorator
  delegate_all

  def total_price
    Money.new(book.price_cents * quantity)
  end
end
