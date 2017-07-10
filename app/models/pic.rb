class Pic < ApplicationRecord
  has_many :deals
  belongs_to :belongable, polymorphic: true, optional: true
  validates :name, presence: true
end
