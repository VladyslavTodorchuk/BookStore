FactoryBot.define do
  factory :author do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }

    transient do
      books_count { 1 }
    end

    after :create do |author, books_count|
      author.books do
        Array.new(books_count) do
          association(:author, books: [instance])
        end
      end
    end
  end
end
