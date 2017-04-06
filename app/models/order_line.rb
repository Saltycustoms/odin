class OrderLine < ApplicationRecord
  belongs_to :design
  belongs_to :order
  belongs_to :blank

  accepts_nested_attributes_for :design
end
