FactoryBot.define do
  factory :review do
    title { FFaker::Lorem.words(5) }
    rating { FFaker::Number.rand(0..5) }
    body { FFaker::Lorem.words(500) }
  end
end
