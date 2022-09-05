class BooksCategory < ApplicationRecord
  belongs_to :category
  belongs_to :book

  validates :category, :book, presence: true

end
