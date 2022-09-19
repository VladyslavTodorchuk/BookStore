class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :title, presence: true, length: { maximum: 80 },
                    format: { with: %r{\A[A-Za-z0-9!#$%&'*+-/=?^_`{|}~. ]+\z}, message: I18n.t('review.errors.title') }
  validates :body, presence: true, length: { maximum: 500 },
                   format: { with: %r{\A[A-Za-z0-9!#$%&'*+-/=?^_`{|}~. ]+\z}, message: I18n.t('review.errors.body') }

  validates :verified, inclusion: { in: [true, false] }, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }, presence: true
end
