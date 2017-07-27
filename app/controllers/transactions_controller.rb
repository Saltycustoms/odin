class TransactionsController < ApplicationController
  before_action :set_deal
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
    @transactions = @deal.transactions
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = @deal.transactions.new(transaction_params)

    if @transaction.save
      redirect_to @deal, notice: "Transaction was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @transaction.update(transaction_params)
      redirect_to @deal, notice: "Transaction was successfully updated."
    else
      render :edit
    end
  end

  private
  def set_deal
    @deal = Deal.find(params[:deal_id])
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:transaction_number, :gateway_id, :value)
  end
end
