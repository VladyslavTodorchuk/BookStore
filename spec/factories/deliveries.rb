FactoryBot.define do
  factory :delivery do
    price_cents { rand(0...10_000) }
    delivery_method { FFaker::Lorem.word }
    delivery_day { rand(1..5) }
  end
end
