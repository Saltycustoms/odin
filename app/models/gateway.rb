class Gateway < ApplicationRecord
  acts_as_paranoid
  validates :name, presence: true
  has_many :transactions
end
