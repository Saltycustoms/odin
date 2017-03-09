class ShippingZonesController < ApplicationController
  before_action :set_shipping_zone, only: [:show, :edit, :update, :destroy]

  # GET /shipping_zones
  # GET /shipping_zones.json
  def index
    @shipping_zones = ShippingZone.all
  end

  # GET /shipping_zones/1
  # GET /shipping_zones/1.json
  def show
  end

  # GET /shipping_zones/new
  def new
    @shipping_zone = ShippingZone.new
  end

  # GET /shipping_zones/1/edit
  def edit
  end

  # POST /shipping_zones
  # POST /shipping_zones.json
  def create
    @shipping_zone = ShippingZone.new(shipping_zone_params)

    respond_to do |format|
      if @shipping_zone.save
        format.html { redirect_to @shipping_zone, notice: 'Shipping zone was successfully created.' }
        format.json { render :show, status: :created, location: @shipping_zone }
      else
        format.html { render :new }
        format.json { render json: @shipping_zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipping_zones/1
  # PATCH/PUT /shipping_zones/1.json
  def update
    respond_to do |format|
      if @shipping_zone.update(shipping_zone_params)
        format.html { redirect_to @shipping_zone, notice: 'Shipping zone was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipping_zone }
      else
        format.html { render :edit }
        format.json { render json: @shipping_zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipping_zones/1
  # DELETE /shipping_zones/1.json
  def destroy
    @shipping_zone.destroy
    respond_to do |format|
      format.html { redirect_to shipping_zones_url, notice: 'Shipping zone was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipping_zone
      @shipping_zone = ShippingZone.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipping_zone_params
      params.require(:shipping_zone).permit(:name, :disabled)
    end
end
