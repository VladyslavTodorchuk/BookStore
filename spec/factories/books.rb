FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    price_cents { FFaker::Number.rand(10_000) }
    materials { FFaker::Book.cover(:format) }
    year_of_publication { FFaker::Number.rand(1900..2022) }
    dimensions { FFaker::Book.cover(:size) }
    quantity { FFaker::Number.rand(0..10) }

    factory :book_with_authors do
      transient do
        authors_count { 1 }
      end

      posts do
        Array.new(authors_count) { association(:author) }
      end
    end

    factory :book_with_categories do
      transient do
        categories_count { 1 }
      end

      posts do
        Array.new(categories_count) { association(:category) }
      end
    end
  end
end
