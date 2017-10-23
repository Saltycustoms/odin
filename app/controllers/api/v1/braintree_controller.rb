class Api::V1::BraintreeController < ApiController
  def generate_token
    @gateway = Gateway::BraintreeSDK.first
    render json: @gateway.generate_token
  end
end
