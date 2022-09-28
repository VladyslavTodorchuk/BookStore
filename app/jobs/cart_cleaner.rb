class CartCleaner < ApplicationJob
  include Sidekiq::Job

  def perform(order_id)
    order = Order.find(order_id)
    if order.status.eql?('initialized') || (order.last_action - DateTime.now).eql?(168)
      order.destroy
    end
  end
end