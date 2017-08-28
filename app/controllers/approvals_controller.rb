class ApprovalsController < ApplicationController
  before_action :authorize_user, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_approval, only: [:edit, :update, :destroy]
  before_action :set_deal, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :approvers_collection, only: [:new, :edit]
  before_action :acknowledgers_collection, only: [:new, :edit]
  before_action :employees_collection, only: [:new, :edit]

  def index
    @approvals = Approval.where(deal_id: params[:deal_id])
  end

  def new
    @approval = Approval.new(deal_id: @deal.id, description: "")
  end

  def create
    #active resource need to initialize
    @approval = Approval.new(approval_params)
    # @approval.description = approval_params[:description]
    if @approval.save
      redirect_to @deal
    else
      render :new
    end
  end

  def edit
  end

  def update
    @approval.description = approval_params[:description]
    if @approval.save
      redirect_to @deal
    else
      render :edit
    end
  end

  def destroy
    @approval.destroy
    redirect_to @deal
  end

  private

  def set_approval
    @approval = Approval.find(params[:id])
  end

  def set_deal
    @deal = Deal.find(params[:deal_id])
  end

  def approvers_collection
    if params[:id].blank?
      @approvers = []
    else
      @approvers = Approval.find(params[:id]).approvers
    end
  end

  def acknowledgers_collection
    if params[:id].blank?
      @acknowledgers = []
    else
      @acknowledgers = Approval.find(params[:id]).acknowledgers
    end
  end

  def employees_collection
    @employees = Employee.all
  end

  def approval_params
    params.require(:approval).permit(:description, :deal_id, :hello, approver_ids:[],
     acknowledger_ids:[])
  end

  def authorize_user
    if !current_user.has_any_role? :admin, :apparel_consultant, :director
      redirect_to request.referrer ? request.referrer : root_path, notice: "You are not authorized."
    end
  end
end
