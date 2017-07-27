class ConditionsController < ApplicationController
  def index
    #deal
    #show conditions that should be met for this deal
    @deal = Deal.find(params[:deal_id])
  end

  def show
  end
end
