class Department < ApplicationRecord
  has_many :deals
  has_many :pics, as: :belongable, dependent: :destroy
  accepts_nested_attributes_for :pics, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  belongs_to :organization
  validates :name, presence: true
end
