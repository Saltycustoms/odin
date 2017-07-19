class Organization < ApplicationRecord
  acts_as_taggable
  has_many :departments
  validates :name, presence: true
  validates :industry, presence: true
end
