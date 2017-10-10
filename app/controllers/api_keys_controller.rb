class ApiKeysController < ApplicationController
  http_basic_authenticate_with name: "salty", password: "customs"

  def index
    @api_key = ApiKey.new
    @api_keys = ApiKey.all
  end

  def create
    @api_key = ApiKey.new(api_key_params)
    @api_key.save
    redirect_to api_keys_path
  end

  private

  def api_key_params
    params.require(:api_key).permit([:id, :access_token, :app])
  end
end
