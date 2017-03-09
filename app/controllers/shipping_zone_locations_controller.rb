class ShippingZoneLocationsController < ApplicationController
  before_action :set_shipping_zone_location, only: [:show, :edit, :update, :destroy]

  # GET /shipping_zone_locations
  # GET /shipping_zone_locations.json
  def index
    @shipping_zone_locations = ShippingZoneLocation.all
  end

  # GET /shipping_zone_locations/1
  # GET /shipping_zone_locations/1.json
  def show
  end

  # GET /shipping_zone_locations/new
  def new
    @shipping_zone_location = ShippingZoneLocation.new
  end

  # GET /shipping_zone_locations/1/edit
  def edit
  end

  # POST /shipping_zone_locations
  # POST /shipping_zone_locations.json
  def create
    @shipping_zone_location = ShippingZoneLocation.new(shipping_zone_location_params)

    respond_to do |format|
      if @shipping_zone_location.save
        format.html { redirect_to @shipping_zone_location, notice: 'Shipping zone location was successfully created.' }
        format.json { render :show, status: :created, location: @shipping_zone_location }
      else
        format.html { render :new }
        format.json { render json: @shipping_zone_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipping_zone_locations/1
  # PATCH/PUT /shipping_zone_locations/1.json
  def update
    respond_to do |format|
      if @shipping_zone_location.update(shipping_zone_location_params)
        format.html { redirect_to @shipping_zone_location, notice: 'Shipping zone location was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipping_zone_location }
      else
        format.html { render :edit }
        format.json { render json: @shipping_zone_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipping_zone_locations/1
  # DELETE /shipping_zone_locations/1.json
  def destroy
    @shipping_zone_location.destroy
    respond_to do |format|
      format.html { redirect_to shipping_zone_locations_url, notice: 'Shipping zone location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipping_zone_location
      @shipping_zone_location = ShippingZoneLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipping_zone_location_params
      params.require(:shipping_zone_location).permit(:country_code, :state, :shipping_zone_id)
    end
end
