class Book < ApplicationRecord
  belongs_to :author

  validate :title, presence: true
  validate :description, presence: true
  validate :price, presence: true
end
