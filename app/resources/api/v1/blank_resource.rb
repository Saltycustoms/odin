class Api::V1::BlankResource < JSONAPI::Resource
  attributes :price_cents, :id, :name
  has_many :surfaces
end
