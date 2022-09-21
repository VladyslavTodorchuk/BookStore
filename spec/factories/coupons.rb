FactoryBot.define do
  factory :coupon do
    code { SecureRandom.hex }
<<<<<<< HEAD
    is_active { true }
    active_till_date { FFaker::Time.datetime }
    discount { rand(0..50) / 100 }
=======
    is_active { false }
    active_till_date { FFaker::Time.datetime }
    discount { rand(0..100) }
>>>>>>> a46d772 (Add Modle Order, OrderBook, Coupon)
  end
end
