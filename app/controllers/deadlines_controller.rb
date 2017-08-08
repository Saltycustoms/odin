class DeadlinesController < ApplicationController
  before_action :set_deal, except: [:show]

  def index
    @deadlines = @deal.deadlines.order(created_at: :desc)
  end

  def show
    @deadline = Deadline.find(params[:id])
    open_notification(@deadline, self, current_user) if params[:opened]
  end

  def new
    @deadline = Deadline.new
  end

  def create
    @deadline = @deal.deadlines.new(deadline_params)

    if @deadline.save
      send_notification(@deadline, self)
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
