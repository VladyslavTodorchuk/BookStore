class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :title, presence: true, length: { maximum: Constants::VALIDATES_TITLE_LENGTH_MAX },
                    format: { with: %r{\A[A-Za-z0-9!#$%&'*+-/=?^_`{|}~. ]+\z}, message: I18n.t('review.errors.title') }
  validates :body, presence: true, length: { maximum: Constants::VALIDATES_TEXT_LENGTH_MAX },
                   format: { with: %r{\A[A-Za-z0-9!#$%&'*+-/=?^_`{|}~. ]+\z}, message: I18n.t('review.errors.body') }

  validates :verified, inclusion: { in: [true, false] }, presence: true
  validates :rating,
            numericality: {
              greater_than_or_equal_to: Constants::STAR_MIN,
              less_than_or_equal_to: Constants::STAR_MAX
            }, presence: true
end
