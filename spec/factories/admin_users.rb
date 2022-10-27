FactoryBot.define do
  factory :admin_user do
    email { FFaker::Internet.email }
    password { 'adminPassword' }
  end
end
