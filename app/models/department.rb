class Department < ApplicationRecord
  has_many :deals
  validates :name, presence: true
end
