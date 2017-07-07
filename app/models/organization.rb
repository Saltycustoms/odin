class Organization < ApplicationRecord
  has_many :departments
  validates :name, presence: true
  validates :industry, presence: true
end
