FactoryBot.define do
  factory :order do
    coupon
    status { 'created' }
    user
  end
end
