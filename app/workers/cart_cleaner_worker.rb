class CartCleanerWorker
  include Sidekiq::Worker
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)
    order.destroy if order.status.eql?('initialized')
  end
end
