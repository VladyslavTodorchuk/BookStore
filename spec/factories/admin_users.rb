FactoryBot.define do
  factory :admin_user do
    email { "admin-#{FFaker::Name.last_name}@admin.ua" }
    password { 'adminPassword' }
  end
end
