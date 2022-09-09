FactoryBot.define do
  factory :billing do
    user
    address { FFaker::AddressUA.street_address }
    city { FFaker::AddressUA.city }
    zip { FFaker::AddressUA.zip_code }
    country { FFaker::AddressUA.country }
    phone { FFaker::PhoneNumberUA.home_phone_number }
  end
end
