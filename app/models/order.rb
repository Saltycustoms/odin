class Order < ApplicationRecord
  has_many :payments
  has_many :designs
  has_many :lines, class_name: 'OrderLine'
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'

  accepts_nested_attributes_for :payments, :designs, :lines, allow_destroy: true
  accepts_nested_attributes_for :shipping_address, :billing_address

  after_initialize :default_values

  def default_values
    require 'securerandom'
    self.uuid ||= SecureRandom.uuid
  end
end
