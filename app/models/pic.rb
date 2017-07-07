class Pic < ApplicationRecord
  belongs_to :belongable, polymorphic: true
end
