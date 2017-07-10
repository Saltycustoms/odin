class DeadlinesController < ApplicationController
  before_action :set_deal

  def index
  end

  def new
    @deadline = Deadline.new
  end

  def create
    @deadline = @deal.deadlines.new(deadline_params)

    if @deadline.save
      redirect_to @deal, notice: "Deadline was successfully created."
    else
      render :new
    end
  end

  private
  def set_deal
    @deal = Deal.find(params[:deal_id])
  end

  def deadline_params
    params.require(:deadline).permit(:deadline, :reason, :cause_by)
  end
end
