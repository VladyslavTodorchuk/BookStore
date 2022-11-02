# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')

  category = Category.create!(name: FFaker::Book.genre)
  author = Author.create!(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name)

  16.times do
    book = Book.create!(title: FFaker::Book.title,
                        description: FFaker::Book.description,
                        price_cents: FFaker::Number.rand(10_000),
                        materials: FFaker::Book.cover(:format),
                        year_of_publication: FFaker::Number.rand(1900..2022),
                        dimensions: FFaker::Book.cover(:size),
                        quantity: FFaker::Number.rand(2..10))

    BooksCategory.create!(book: book, category: category)
    AuthorsBook.create!(book: book, author: author)
  end
end
