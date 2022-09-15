class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :title, :body, presence: true
  validates :verified, inclusion: { in: [true, false] }
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }, presence: true
end
