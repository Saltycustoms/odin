class Pic < ApplicationRecord
  acts_as_paranoid
  has_many :deals
  belongs_to :belongable, polymorphic: true, optional: true
  validates :name, :email, presence: true
end
