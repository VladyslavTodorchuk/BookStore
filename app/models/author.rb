require_relative 'application_record'

class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :first_name, presence: true, format: { with: /\A[a-zA-Z-]+\z/, message: 'Fist Name is invalid' },
            length: { in: 2..50 }
  validates :last_name, presence: true, format: { with: /\A[a-zA-Z-]+\z/, message: 'Last Name is invalid' },
            length: { in: 2..50 }
end
