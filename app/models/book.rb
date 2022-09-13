class Book < ApplicationRecord
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books

  has_many :books_categories, dependent: :destroy
  has_many :categories, through: :books_categories

  validates :title, :description, :year_of_publication, :materials, :dimensions, presence: true
  validates :price_cents, :quantity, presence: true,
                                     numericality:
                                 { greater_than_or_equal_to: Constants::GREATER_THEN_ORT_EQUAL_TO,
                                   less_than_or_equal_to: Constants::LESS_THEN_OR_EQUAL_TO }
end
