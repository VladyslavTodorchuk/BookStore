class BookService
  def self.quantity_update(params, product, order, book, coupon)
    discount = 0
    product.update(quantity: params[:quantity]) if params[:quantity].to_i <= book.quantity
    discount = coupon.discount unless coupon.nil?

    if product.save
      {
        total_price: order.decorate.order_price(discount).to_s,
        sub_price: order.decorate.order_price.to_s,
        price: product.decorate.total_price.to_s,
        discount: (order.decorate.order_price * discount).to_s,
        book_quantity: book.quantity
      }
    else
      { notice: 'Error!' }
    end
  end
end
