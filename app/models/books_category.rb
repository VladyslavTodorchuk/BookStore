class BooksCategory < ApplicationRecord
  belongs_to :category
  belongs_to :book

  validates :book, :category, presence: true
end
