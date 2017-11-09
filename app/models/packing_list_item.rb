class PackingListItem < ApplicationRecord
  acts_as_paranoid
  validates :quantity, numericality: { greater_than_or_equal_to: 0}
  belongs_to :packing_list
end
