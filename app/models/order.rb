class Order < ApplicationRecord
  has_many :payments
  has_many :designs
  has_many :lines, class_name: 'OrderLine'
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  enum status: {
    start: 0,
    pending: 10,
    paid: 20,
    ready_for_print: 30,
    manufacturing: 40,
    packing: 50,
    shipping: 60,
    completed: 100,
    cancelled: 110,
    void: 120
  }

  accepts_nested_attributes_for :payments, :designs, :lines, allow_destroy: true
  accepts_nested_attributes_for :shipping_address, :billing_address

  after_initialize :default_values

  def default_values
    require 'securerandom'
    self.uuid ||= SecureRandom.uuid
  end
end
