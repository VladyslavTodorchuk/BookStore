FactoryBot.define do
  factory :review do
    title { FFaker::Lorem.words(5) }
    rating { FFaker::Number.rand(0.0..5.0) }
    body { FFaker::Lorem.words(500) }
  end
end
