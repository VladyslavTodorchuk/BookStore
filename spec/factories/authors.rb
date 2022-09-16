FactoryBot.define do
  factory :author do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }

    trait :with_books do
      transient do
        books_count { 1 }
      end

      books do
        Array.new(books_count) { association(:books) }
      end
    end
  end
end
