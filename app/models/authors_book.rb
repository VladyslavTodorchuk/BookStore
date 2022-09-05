class AuthorsBook < ApplicationRecord
  belongs_to :author
  belongs_to :book

<<<<<<< HEAD
  validates :book, :author, presence: true
=======
  validates :author, :book, presence: true
>>>>>>> home_page
end
