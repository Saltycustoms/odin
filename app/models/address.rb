class Address < ApplicationRecord
  acts_as_paranoid
  belongs_to :belongable, polymorphic: true, optional: true

  def to_html
    arr = []
    arr << name if name.present?
    arr << address1
    arr << address2 if address2.present?
    arr << "#{city} #{postal_code}"
    arr << state if state.present?
    arr << ISO3166::Country[country_code]
    arr.join(", <br/>").html_safe
  end
end
