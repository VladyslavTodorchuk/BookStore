FactoryBot.define do
  factory :coupon do
    code { SecureRandom.hex }
    is_active { false }
    active_till_date { FFaker::Time.datetime }
    discount { rand(0..100) }
  end
end
