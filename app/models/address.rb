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

  def to_transactional
    {
      country_code_alpha2: self.country_code,
      postal_code: self.post_code,
      street_address: self.line1,
      extended_address: self.line2,
      region: self.state,
      locality: self.city,
      first_name: self.att,
      company: ''
    }
  end
end
