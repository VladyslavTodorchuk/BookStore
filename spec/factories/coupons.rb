FactoryBot.define do
  factory :coupon do
    code { SecureRandom.hex }
    is_active { true }
    active_till_date { FFaker::Time.datetime }
    discount { rand(0..50) / 100 }
  end
end
