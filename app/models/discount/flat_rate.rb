class Discount::FlatRate < Discount
  def calculate(sub_total_cents = nil)
    (self.value * 100).round
  end

  def info
    if self.value.present? && self.quotation.present?
      "(#{self.quotation.currency} #{self.value} OFF)"
    end
  end
end
