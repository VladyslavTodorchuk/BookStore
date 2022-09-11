class Billing < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, presence: true

  validates :zip, numericality: { only_integer: true }, allow_blank: true
end
