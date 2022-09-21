FactoryBot.define do
  factory :order do
<<<<<<< HEAD
    status { 'initialized' }
    delivery

    transient do
      books_count { 1 }
    end

    after :create do |order, books_count|
      order.books do
        Array.new(books_count) do
          association(:order, books: [instance])
        end
      end
    end
=======
    coupon
    status { 'created' }
    user
>>>>>>> a46d772 (Add Modle Order, OrderBook, Coupon)
  end
end
