FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { 'password' }
    confirmed_at { Time.zone.now }
  end
end
