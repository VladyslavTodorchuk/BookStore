class BooksCategory < ApplicationRecord
  belongs_to :category
  belongs_to :book

<<<<<<< HEAD
  validates :book, :category, presence: true
=======
  validates :category, :book, presence: true
>>>>>>> home_page
end
