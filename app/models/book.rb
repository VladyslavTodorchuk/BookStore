class Book < ApplicationRecord
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books

  has_many :books_categories, dependent: :destroy
  has_many :categories, through: :books_categories

  validates :title, presence: true
  validates :description, presence: true
  validates :price, :year_of_publication, :materials, :dimensions, presence: true
end
