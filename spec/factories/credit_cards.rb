FactoryBot.define do
  factory :credit_card do
    user { user }
    code { rand(0...10).to_s * 16 }
    name { FFaker::Lorem.word }
    cvv { rand(0...10).to_s * 3 }
    expiration_date { (Time.zone.now + rand(1..10).year * rand(0..1)).strftime('%m/%y') }
  end
end
