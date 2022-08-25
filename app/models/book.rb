require_relative 'application_record'

class Book < ApplicationRecord
  belongs_to :author

  validates :name, presence: true, length: { in: 2..80 },
            format: { with: %r{\A[a-zA-Z!#$%&'*+-/=?^_`{|}~.]+\z}, message: 'Name is invalid' }
  validates :description, presence: true, length: { in: 2..500 },
            format: { with: %r{\A[a-zA-Z!#$%&'*+-/=?^_`{|}~.]+\z}, message: 'Description is invalid' }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
