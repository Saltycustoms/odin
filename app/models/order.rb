class Order < ApplicationRecord
  has_many :payments
  has_many :designs
end
