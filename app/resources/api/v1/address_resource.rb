class Api::V1::AddressResource < JSONAPI::Resource
  attributes :id, :user_id, :att, :line1, :line2, :state, :post_code, :country_code, :city, :tel
end
