class Department < ApplicationRecord
  has_many :deals
  belongs_to :organization
  validates :name, presence: true
end
