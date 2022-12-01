class Address < ApplicationRecord
  TEXT_FORMAT = %r{\A[A-Za-zа-яА-я0-9!#$%&'*+-/=?^_`{|}~. ]+\z}.freeze
  NAME_FORMAT = /\A[A-Za-z]+\z/.freeze
  COUNTY_FORMAT = /\A[A-Za-zа-яА-я ]+\z/.freeze
  PHONE_FORMAT = /\A[\\+]?[(]?[0-9]{3}[)]?[-\s\\.]?[0-9]{3}[-\s\\.]?[0-9]{4,6}\z/.freeze
  ZIP_FORMAT = /\A[0-9]+\z/.freeze

  VALIDATES_NAME_LENGTH_MAX = 50
  VALIDATES_TITLE_LENGTH_MAX = 80
  VALIDATES_PHONE_LENGTH_MAX = 15
  VALIDATES_ZIP_LENGTH_MAX = 10

  belongs_to :user
  has_many :orders, dependent: :nullify

  validates :first_name, :last_name,
            length: { maximum: VALIDATES_NAME_LENGTH_MAX },
            format: { with: NAME_FORMAT,
                      message: 'Please enter first or last in correct format' }, allow_blank: true
  validates :phone,
            length: { maximum: VALIDATES_PHONE_LENGTH_MAX },
            format: { with: PHONE_FORMAT,
                      message: 'Please enter phone in correct format' }, allow_blank: true
  validates :address,
            length: { maximum: VALIDATES_TITLE_LENGTH_MAX },
            format: { with: TEXT_FORMAT,
                      message: 'Please enter address in correct format' }, allow_blank: true
  validates :country, :city,
            length: { maximum: VALIDATES_TITLE_LENGTH_MAX },
            format: { with: COUNTY_FORMAT,
                      message: 'Please enter country in correct format' }, allow_blank: true
  validates :zip,
            length: { maximum: VALIDATES_ZIP_LENGTH_MAX },
            format: { with: ZIP_FORMAT,
                      message: 'Please enter zip in correct format' }, allow_blank: true
end
