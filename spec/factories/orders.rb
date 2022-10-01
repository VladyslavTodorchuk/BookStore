FactoryBot.define do
  factory :order do
    status { 'created' }

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
  end
end
