FactoryBot.define do
  factory :coupon do
    code { SecureRandom.hex }
    discount { rand(0..50) / 100 }
    active_till_date { FFaker::Time.datetime }
  end
end
