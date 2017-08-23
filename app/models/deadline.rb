class Deadline < ApplicationRecord
  acts_as_paranoid
  belongs_to :deal
  validates :deadline, :reason, :cause_by, presence: true, if: :change_deadline?

  def change_deadline?
    deal.deadlines.size > 1
  end
end
