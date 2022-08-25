class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validate :first_name, presence: true, length: 2..80
  validate :last_name, presence: true, length: 2..80
end
