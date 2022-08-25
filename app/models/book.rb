class Book < ApplicationRecord
  belongs_to :author

  validate :title, presence: true, length: 2..80
  validate :description, presence: true, length: 2..500
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
