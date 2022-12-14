require 'monetize'

class OrderDecorator < Draper::Decorator
  delegate_all

  def order_price(coupon = 0, delivery = 0)
    total_price = 0
    order_books.each do |order_book|
      total_price += order_book.book.price_cents * order_book.quantity
    end
    Money.new(total_price - (total_price * coupon) + delivery)
  end

  def price
    Money.new(total_price)
  end

  def date_time
    created_at.strftime('%m %d, %Y')
  end

  def last_action_str
    updated_at.strftime('%F')
  end
end
