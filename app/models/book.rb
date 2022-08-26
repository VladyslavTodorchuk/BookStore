class Book < ApplicationRecord
  belongs_to :author

  validates :title, presence: true, length: { in: 2..80 },
                    format: { with: %r{\A[a-zA-Z!#$%&'*+-/=?^_`{|}~. ]+\z}, message: 'Title is invalid' }
  validates :description, presence: true, length: { in: 2..500 },
                          format: { with: %r{\A[a-zA-Z!#$%&'*+-/=?^_`{|}~. ]+\z}, message: 'Description is invalid' }
  validates :price, presence: true
end
