class ActiveResourceRecord < ActiveResource::Base
  #it must be double quote
  access_token = ApiKey.where(app: "deal").take&.access_token
  if access_token.present?
    authorization_string = 'Token token="' + access_token + '"'
    self.headers['Authorization'] = authorization_string
  end
end
