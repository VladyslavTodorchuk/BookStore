FactoryBot.define do
  factory :user do
    email { "#{FFaker::Name.first_name.downcase}.#{FFaker::Name.last_name.downcase}@#{FFaker::Company.name.downcase}.com" }
    password { 'password' }
  end
end
