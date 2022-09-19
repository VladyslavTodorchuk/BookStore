class Book < ApplicationRecord
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books

  has_many :books_categories, dependent: :destroy
  has_many :categories, through: :books_categories

  has_many_attached :images, dependent: :destroy

  has_many :reviews, dependent: :destroy

  validates :title, :description, :year_of_publication, :materials, :dimensions, presence: true
  validates :price_cents, :quantity, presence: true,
                                     numericality:
              { greater_than_or_equal_to: Constants::MIN_PRICE_IN_CENTS,
                less_than_or_equal_to: Constants::MAX_PRICE_IN_CENTS }
end
