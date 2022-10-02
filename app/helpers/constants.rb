module Constants
  PAGINATION_PER_PAGE = 12

  CATALOG_BOOK_COUNT = 3
  BEST_SELLER_COUNT = 4
  DESCRIPTION_LENGTH = 25
  MIN_PRICE_IN_CENTS = 0
  MAX_PRICE_IN_CENTS = 10_000

  TEXT_FORMAT = %r{\A[A-Za-z0-9!#$%&'*+-/=?^_`{|}~. ]+\z}.freeze
  NAME_FORMAT = /\A[A-Za-z]+\z/.freeze
  PHONE_FORMAT = /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/.freeze
  ZIP_FORMAT = /\A[0-9]+\z/.freeze

  VALIDATES_NAME_LENGTH_MAX = 50
  VALIDATES_TEXT_LENGTH_MAX = 500
  VALIDATES_TITLE_LENGTH_MAX = 80
  VALIDATES_PHONE_LENGTH_MAX = 15
  VALIDATES_ZIP_LENGTH_MAX = 10

  FOOTER_NUMBER = '(555)-555-5555'.freeze
  FOOTER_EMAIL = 'support@bookstore.com'.freeze
end
