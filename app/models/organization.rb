class Organization < ApplicationRecord
  acts_as_taggable
  acts_as_paranoid
  has_many :departments, dependent: :destroy
  validates :name, presence: true
  validates :industry, presence: true
end
