FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    price { FFaker::Number.rand(100) }
    materials { 'Soft' }
    year_of_publication { FFaker::Number.rand(1900..2022) }
    dimensions { '30:20:14' }
  end
end
