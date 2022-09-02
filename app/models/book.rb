class Book < ApplicationRecord
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books

  has_many :books_categories, dependent: :destroy
  has_many :categories, through: :books_categories

  validates :title, presence: true
  validates :description, presence: true
  validates :year_of_publication, :quantity, :materials, :dimensions, presence: true
  validates :price,  presence: true,
                     numericality: { greater_than_or_equal_to: 0.0, less_than_or_equal_to: 100 }
end
