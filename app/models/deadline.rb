class Deadline < ApplicationRecord
  acts_as_paranoid
  belongs_to :deal
  validates :deadline, :reason, :cause_by, presence: true, if: :change_deadline?
  before_save :check_for_rush_order

  def change_deadline?
    deal.deadlines.size > 1
  end

  def check_for_rush_order
    if self.deadline_changed?
      self.rush_order = self.deadline < 9.business_days.from_now.end_of_day
    end
  end
end
