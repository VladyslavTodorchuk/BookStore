FactoryBot.define do
  factory :delivery do
    price_cents { rand(0...10_000) }
    delivery_method { FFaker::Lorem.word }
    delivery_date { Date.now + rand(1..5).day }
  end
end
