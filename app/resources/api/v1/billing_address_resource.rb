class Api::V1::BillingAddressResource < JSONAPI::Resource
  attributes :user_id, :att, :line1, :line2, :state, :post_code, :country_code, :city, :tel
  model_name 'Address'
end
