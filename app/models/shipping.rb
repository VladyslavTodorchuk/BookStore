class Shipping < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name,
            length: { maximum: Constants::VALIDATES_NAME_LENGTH_MAX },
            format: { with: Constants::NAME_FORMAT,
                      message: 'Please enter first or last in correct format' }, allow_blank: true
  validates :phone,
            length: { maximum: Constants::VALIDATES_PHONE_LENGTH_MAX },
            format: { with: Constants::PHONE_FORMAT,
                      message: 'Please enter phone in correct format' }, allow_blank: true
  validates :address,
            length: { maximum: Constants::VALIDATES_TITLE_LENGTH_MAX },
            format: { with: Constants::TEXT_FORMAT,
                      message: 'Please enter address in correct format' }, allow_blank: true
  validates :country, :city,
            length: { maximum: Constants::VALIDATES_TITLE_LENGTH_MAX },
            format: { with: Constants::COUNTY_FORMAT,
                      message: 'Please enter country in correct format' }, allow_blank: true
  validates :zip,
            length: { maximum: Constants::VALIDATES_ZIP_LENGTH_MAX },
            format: { with: Constants::ZIP_FORMAT,
                      message: 'Please enter zip in correct format' }, allow_blank: true
end
