FactoryBot.define do
  factory :user do
    email do
      "#{FFaker::Name.first_name.downcase}.#{FFaker::Name.last_name.downcase}@#{FFaker::Company.name.downcase}.com"
    end
    password { 'password' }
  end
end
