FactoryBot.define do
  factory :credit_card do
<<<<<<< HEAD
    code { FFaker::Bank.card_number.split(' ').join }
    name { "#{FFaker::Name.first_name} #{FFaker::Name.last_name}" }
    cvv { rand(0...10).to_s * 3 }
    expiration_date { FFaker::Bank.card_expiry_date }
=======
    user { user }
    code { rand(0...10).to_s * 16 }
    name { FFaker::Lorem.word }
    cvv { rand(0...10).to_s * 3 }
    expiration_date { (Time.zone.now + rand(1..10).year * rand(0..1)).strftime('%m/%y') }
>>>>>>> 3d8a663e (Add Modles for Delivery and Credit Card + Add Address page and controller for all stepts)
  end
end
