FactoryBot.define do
  factory :order_book do
    order
    book
    quantity { 1 }
  end
end
