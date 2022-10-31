class CreditCard < ApplicationRecord
  CARD_NAME_MAX_LENGTH = 50
  CARD_NAME_FORMAT = /\A[a-zA-Z ']*\z/.freeze
  CARD_CVV_FORMAT = /\A[0-9]{3}\z/.freeze
  CARD_DATE_FORMAT = %r{\A(0[1-9]|1[0-2])/?([0-9]{4}|[0-9]{2})\z}.freeze
  CARD_CODE_FORMAT = /\A[0-9]{16}\z/.freeze

  belongs_to :user

  validates :name, length: { maximum: CARD_NAME_MAX_LENGTH }, format: { with: CARD_NAME_FORMAT },
                   allow_blank: true
  validates :expiration_date, format: { with: CARD_DATE_FORMAT },
                              allow_blank: true
  validates :cvv, format: { with: CARD_CVV_FORMAT },
                  allow_blank: true
  validates :code, format: { with: CARD_CODE_FORMAT },
                   allow_blank: true
end
