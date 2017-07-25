class Address < ApplicationRecord
  belongs_to :belongable, polymorphic: true, optional: true
  validates :address1, :city, :postal_code, :country_code, presence: true
end
