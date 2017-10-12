class CouponsController < ApplicationController
  def index
    @coupons = Coupon.all
  end

  def new
    @coupon = Coupon.new
    @coupon.build_discount
  end

  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
      redirect_to coupons_path
    else
      render :new
    end
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def update
    @coupon = Coupon.find(params[:id])
    if @coupon.update(coupon_params)
      redirect_to coupons_path
    else
      render :edit
    end
  end

  def show

  end

  private

  def coupon_params
    params.require(:coupon).permit(:id, :name, :code, :from, :to,
            discount_attributes: [:id, :type, :value, :_destroy])
  end
end
