class CreditCard < ApplicationRecord
  belongs_to :user

  validates :name, length: { maximum: Constants::CARD_NAME_MAX_LENGTH }, format: { with: Constants::CARD_NAME_FORMAT },
                   allow_blank: true
  validates :expiration_date, format: { with: Constants::CARD_DATE_FORMAT },
                              allow_blank: true
  validates :cvv, format: { with: Constants::CARD_CVV_FORMAT },
                  allow_blank: true
  validates :code, format: { with: Constants::CARD_CODE_FORMAT },
                   allow_blank: true
end
