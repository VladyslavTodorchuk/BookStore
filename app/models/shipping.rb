class Shipping < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, :phone, :city, :address, :country, :zip, presence: true
end
