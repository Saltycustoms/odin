class QuotationsController < ApplicationController
  before_action :set_deal
  before_action :set_quotation, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @quotation = Quotation.new
    @quotation.discount.nil? ? @quotation.build_discount : @quotation.discount
  end

  def create
    @quotation = @deal.create_quotation(quotation_params)

    if @quotation.save
      redirect_to @deal, notice: "Quotation was successfully created."
    else
      render :new
    end
  end

  def show
  end

  def edit
    @quotation.discount.nil? ? @quotation.build_discount : @quotation.discount
  end

  def update
    if @quotation.update(quotation_params)
      params[:job_request_price_per_piece].each_pair do |key, param|
        job_request = JobRequest.find(param[:id])
        job_request.quotation_lines.each do |line|
          line.update(price_per_unit: param[:price_per_piece])
        end
      end
      redirect_to deal_quotations_path(@deal), notice: "Quotation was successfully created."
    else
      render :edit
    end
  end

  private
  def set_deal
    @deal = Deal.find(params[:deal_id])
  end

  def set_quotation
    @quotation = @deal.quotation
  end

  def quotation_params
    params.require(:quotation).permit(:discount_id, :payment_term, :currency, :shipping, :tax,
    quotation_lines_attributes: [:id, :price_per_unit, :quantity, :description, :_destroy], discount_attributes: [:id, :type, :value])
  end
end
