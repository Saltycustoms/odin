class Organization < ApplicationRecord
  acts_as_taggable
  acts_as_paranoid
  has_many :departments, dependent: :destroy
  validates :name, presence: true
  validates :industry, presence: true
  has_one :address, as: :belongable, class_name: "Address", dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true
end
