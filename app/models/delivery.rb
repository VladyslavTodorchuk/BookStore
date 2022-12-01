class Delivery < ApplicationRecord
  has_many :orders, dependent: :nullify

  validates :delivery_method, presence: true
end
