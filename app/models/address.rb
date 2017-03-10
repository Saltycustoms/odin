class Address < ApplicationRecord
  belongs_to :user
  has_many :billing_in_orders, foreign_key: 'billing_address_id', class_name: 'Order'
  has_many :shipping_in_orders, foreign_key: 'shipping_address_id', class_name: 'Order'

  validates :att, presence: true
  validates :line1, presence: true
  validates :post_code, presence: true
  validates :country_code, presence: true
  validates :city, presence: true
  validates :tel, presence: true

  def to_html
    [att,
     line1,
     line2,
     "#{city} #{post_code}",
     state,
     ISO3166::Country[country_code],
     "#{tel}"
   ].join(',<br />').html_safe
  end
end
