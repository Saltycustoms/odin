class Gateway < ApplicationRecord
  acts_as_paranoid
  validates :name, presence: true
  has_many :transactions

  class << self
    def types
      ["Gateway::BraintreeSDK", "Gateway::Eghl", "Gateway::PaypalSdk"]
    end
  end
end
