FactoryBot.define do
  factory :address do
    user
    address { FFaker::AddressUK.street_address }
    city { FFaker::AddressUK.city }
    zip { FFaker::AddressUA.zip_code }
    country { FFaker::AddressUK.country }
    phone { FFaker::PhoneNumberUA.home_phone_number }
  end
end
