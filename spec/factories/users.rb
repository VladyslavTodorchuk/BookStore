FactoryBot.define do
  factory :user do
    email do
      "#{FFaker::Name.first_name.downcase}.#{FFaker::Name.last_name.downcase}@rspec.com"
    end
    password { 'password' }
  end
end
