FactoryBot.define do
  factory :review do
    user
    book
    title { FFaker::Lorem.words(5).join(' ') }
    rating { FFaker::Number.rand(0..5) }
    body { FFaker::Lorem.words(10).join(' ') }
    verified { true }
  end
end
