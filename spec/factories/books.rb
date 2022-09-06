FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    price_cents { FFaker::Number.rand(10_000) }
    materials { FFaker::Book.cover(:format) }
    year_of_publication { FFaker::Number.rand(1900..2022) }
    dimensions { FFaker::Book.cover(:size) }
    quantity { FFaker::Number.rand(2..10) }

    transient do
      categories_count { 1 }
    end

    transient do
      authors_count { 1 }
    end

    after :create do |book, authors_count|
      book.authors do
        Array.new(authors_count) do
          association(:book, authors: [instance])
        end
      end
    end

    after :create do |book, categories_count|
      book.categories do
        Array.new(categories_count) do
          association(:book, categories: [instance])
        end
      end
    end

  end
end
