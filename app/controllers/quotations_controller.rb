class QuotationsController < ApplicationController
  before_action :set_job_request
  before_action :set_quotation, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @quotation = Quotation.new
    @quotation.discount.nil? ? @quotation.build_discount : @quotation.discount
  end

  def create
    @quotation = @job_request.create_quotation(quotation_params)

    if @quotation.save
      redirect_to [@job_request.deal, @job_request], notice: "Quotation was successfully created."
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
      redirect_to [@job_request.deal, @job_request], notice: "Quotation was successfully created."
    else
      render :edit
    end
  end

  private
  def set_job_request
    @job_request = JobRequest.find(params[:job_request_id])
  end

  def set_quotation
    @quotation = @job_request.quotation
  end

  def quotation_params
    params.require(:quotation).permit(:deal_id, :discount_id, :job_request_id, :payment_term, :currency, :shipping, :net_total_cents, :sub_total_cents, :tax_cents,
    quotation_lines_attributes: [:id, :price_per_unit_cents, :quantity, :description, :_destroy], discount_attributes: [:id, :type, :value])
  end
end
