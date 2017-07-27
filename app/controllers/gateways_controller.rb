class GatewaysController < ApplicationController
  before_action :set_gateway, only: [:show, :edit, :update, :destroy]

  def index
    @gateways = Gateway.all
  end

  def new
    @gateway = Gateway.new
  end

  def create
    @gateway = Gateway.new(gateway_params)

    if @gateway.save
      redirect_to gateways_path, notice: "Gateway was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @gateway.update(gateway_params)
      redirect_to gateways_path, notice: "Gateway was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @gateway.destroy
    redirect_to gateways_path, notice: "Gateway was successfully destroyed."
  end

  private
  def set_gateway
    @gateway = Gateway.find(params[:id])
  end

  def gateway_params
    params.require(:gateway).permit(:name)
  end
end
