FactoryBot.define do
  factory :review do
    user
    book
    title { FFaker::Lorem.sentence(3) }
    rating { FFaker::Number.rand(Review::STAR_MIN..Review::STAR_MAX) }
    body { FFaker::Lorem.sentence(5) }
    verified { true }
  end
end
