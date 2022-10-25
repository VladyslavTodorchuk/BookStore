class Review < ApplicationRecord
  VALIDATES_TEXT_LENGTH_MAX = 500
  VALIDATES_TITLE_LENGTH_MAX = 80

  belongs_to :user
  belongs_to :book

  validates :title, presence: true, length: { maximum: VALIDATES_TITLE_LENGTH_MAX },
                    format: { with: %r{\A[A-Za-z0-9!#$%&'*+-/=?^_`{|}~. ]+\z}, message: I18n.t('reviews.errors.title') }
  validates :body, presence: true, length: { maximum: VALIDATES_TEXT_LENGTH_MAX },
                   format: { with: %r{\A[A-Za-z0-9!#$%&'*+-/=?^_`{|}~. ]+\z}, message: I18n.t('reviews.errors.body') }

  validates :rating,
            numericality: {
              greater_than_or_equal_to: Constants::STAR_MIN,
              less_than_or_equal_to: Constants::STAR_MAX
            }, presence: true
end
