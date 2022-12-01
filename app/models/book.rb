class Book < ApplicationRecord
  MIN_PRICE_IN_CENTS = 0
  MAX_PRICE_IN_CENTS = 50_000
  # H:6.4\" x W: 0.9\" x D: 5.0
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books

  has_many :books_categories, dependent: :destroy
  has_many :categories, through: :books_categories

  has_many :reviews, dependent: :destroy

  has_many_attached :images

  validates :title, :description, :year_of_publication, :materials, :dimensions, presence: true
  validates :price_cents, :quantity, presence: true,
                                     numericality:
              { greater_than_or_equal_to: MIN_PRICE_IN_CENTS,
                less_than_or_equal_to: MAX_PRICE_IN_CENTS }
end
