class QuotationsController < ApplicationController
  before_action :set_deal
  before_action :set_quotation, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @quotation = Quotation.new
    @quotation.build_discount
    @deal.job_requests.each do |job_request|
      job_request.selected_colors.each do |color|
        job_request.selected_sizes.each do |size|
          @quotation.quotation_lines.new(job_request_id: job_request.id, color_id: color.id, size_id: size.id)
        end
      end
    end
    @job_request_price_per_unit = {}
    @deal.job_requests.each do |job_request|
      @job_request_price_per_unit["#{job_request.id}"] = 0
    end
  end

  def create
    @job_request_price_per_unit = {}
    if params[:job_request_price_per_unit]
      params[:job_request_price_per_unit].each_pair do |key, value|
        @job_request_price_per_unit[key] = value["price_per_unit"]
      end
    else
      @quotation.deal.job_requests.each do |job_request|
        @job_request_price_per_unit["#{job_request.id}"] = job_request.quotation_lines.first.price_per_unit
      end
    end
    new_params = quotation_params.deep_dup
    params[:job_request_price_per_unit].each_pair do |key, param|
      job_request_id = param[:id]
      new_params[:quotation_lines_attributes].each_pair do |key, line|
        if line["job_request_id"] == job_request_id
          line.merge!(price_per_unit: param[:price_per_unit])
        end
      end
    end
    @quotation = @deal.build_quotation(new_params)

    if @quotation.save
      redirect_to deal_quotations_path(@deal), notice: "Quotation was successfully created."
    else
      render :new
    end
  end

  def show
  end

  def edit
    @job_request_price_per_unit = {}
    @quotation.deal.job_requests.each do |job_request|
      @job_request_price_per_unit["#{job_request.id}"] = job_request.quotation_lines.first.price_per_unit
    end
  end

  def update
    @job_request_price_per_unit = {}
    if params[:job_request_price_per_unit]
      params[:job_request_price_per_unit].each_pair do |key, value|
        @job_request_price_per_unit[key] = value["price_per_unit"]
      end
    else
      @quotation.deal.job_requests.each do |job_request|
        @job_request_price_per_unit["#{job_request.id}"] = job_request.quotation_lines.first.price_per_unit
      end
    end
    new_params = quotation_params.deep_dup
    params[:job_request_price_per_unit].each_pair do |key, param|
      job_request_id = param[:id]
      new_params[:quotation_lines_attributes].each_pair do |key, line|
        if line["job_request_id"] == job_request_id
          line.merge!(price_per_unit: param[:price_per_unit])
        end
      end
    end

    if @quotation.update(new_params)
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
    quotation_lines_attributes: [:id, :price_per_unit, :quantity, :job_request_id, :color_id, :size_id, :description, :_destroy], discount_attributes: [:id, :type, :value],
    add_ons_attributes: [:id, :job_request_id, :quantity, :description, :price_per_unit, :_destroy])
  end
end
