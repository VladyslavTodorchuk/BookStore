class CreditCard < ApplicationRecord
  belongs_to :user

  validates :name, length: { maximum: Constants::CARD_NAME_MAX_LENGTH }, format: { with: Constants::CARD_NAME_FORMAT },
                   presence: true
  validates :expiration_date, format: { with: Constants::CARD_DATE_FORMAT }, presence: true
  validates :cvv, format: { with: Constants::CARD_CVV_FORMAT }, presence: true
  validates :code, format: { with: Constants::CARD_CODE_FORMAT }, presence: true
end
