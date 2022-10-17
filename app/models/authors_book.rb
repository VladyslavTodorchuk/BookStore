class AuthorsBook < ApplicationRecord
  belongs_to :author
  belongs_to :book

  validates :author, :book, presence: true
end
