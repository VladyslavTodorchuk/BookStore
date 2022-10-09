class CouponDecorator < Draper::Decorator
  delegate_all

  def to_percentage
    discount * 100
  end
end
