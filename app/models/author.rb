class Author < ApplicationRecord
  has_many :authors_books, dependent: :destroy
  has_many :books, through: :authors_books

  validates :first_name, presence: true
  validates :last_name, presence: true
end
