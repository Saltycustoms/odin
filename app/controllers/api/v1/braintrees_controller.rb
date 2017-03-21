class Api::V1::BraintreesController < ApiController
  def new
    @client_token = Gateway::BraintreeSDK.take.generate_token
    render json: {token: @client_token}
  end
end
