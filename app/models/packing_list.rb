class PackingList < ApplicationRecord
  belongs_to :deal
  has_one :address, as: :belongable, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true
  has_many :pics, as: :belongable, dependent: :destroy
  accepts_nested_attributes_for :pics, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  has_many :packing_list_items, dependent: :destroy
  accepts_nested_attributes_for :packing_list_items, allow_destroy: true, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }
  enum shipping_method:{ delivery: 0, self_pick_up: 1 }
  validates :shipping_method, presence: true
end
