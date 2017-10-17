class Pic < ApplicationRecord
  acts_as_paranoid
  has_many :deals
  belongs_to :belongable, polymorphic: true, optional: true
  belongs_to :billing_address, class_name: "Address"
  validates :name, :email, presence: true
end
