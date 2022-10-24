FactoryBot.define do
  factory :credit_card do
    code { FFaker::Bank.card_number.split(' ').join }
    name { "#{FFaker::Name.first_name} #{FFaker::Name.last_name}" }
    cvv { rand(0...10).to_s * 3 }
    expiration_date { FFaker::Bank.card_expiry_date }
  end
end
