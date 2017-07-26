class Discount::Percentage < Discount
  def calculate(sub_total_cents)
    (self.value.to_f/100 * sub_total_cents).round
  end

  def info
    if self.value.present? && self.quotation.present?
      "(#{self.value}% OFF)"
    end
  end
end
