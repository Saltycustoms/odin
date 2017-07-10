class Deadline < ApplicationRecord
  belongs_to :deal
  validates :deadline, presence: true, if: :change_deadline?
  validates :reason, presence: true, if: :change_deadline?
  validates :cause_by, presence: true, if: :change_deadline?

  def change_deadline?
    deal.deadlines.size > 1
  end
end
