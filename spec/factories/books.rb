FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    price { FFaker::Number.rand(100) }
    materials { FFaker::Book.cover(:format) }
    year_of_publication { FFaker::Number.rand(1900..2022) }
    dimensions { FFaker::Book.cover(:size) }
    quantity { FFaker::Number.rand(0..10) }
  end
end
