class PackingListItem < ApplicationRecord
  acts_as_paranoid
  belongs_to :packing_list
end
