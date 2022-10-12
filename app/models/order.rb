class Order < ApplicationRecord
  has_many :order_books, dependent: :destroy
  has_many :books, through: :order_books

  has_one :coupon, dependent: :nullify
  has_one :address, dependent: :nullify

  belongs_to :delivery, optional: true
end
