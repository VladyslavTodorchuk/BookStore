class CartCleaner < ApplicationJob
  include Sidekiq::Job

  def perform(order_id)
    order = Order.find(order_id)
    order.destroy if order.status.eql?('initialized') || (order.last_action - DateTime.now).eql?(168)
  end
end
