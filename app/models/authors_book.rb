class AuthorsBook < ApplicationRecord
  belongs_to :author
  belongs_to :book

  validates :book, :author, presence: true
end
