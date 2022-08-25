class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validate :first_name, presence: true
  validate :last_name, presence: true
end
