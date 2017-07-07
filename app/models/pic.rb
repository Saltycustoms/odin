class Pic < ApplicationRecord
  belongs_to :belongable, polymorphic: true, optional: true
  validates :name, presence: true
end
