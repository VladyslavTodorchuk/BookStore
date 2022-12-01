class CartCleanerWorker
  include Sidekiq::Job
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)
    order.destroy if order.status.eql?('initialized')
  end
end
