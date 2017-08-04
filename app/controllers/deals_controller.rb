class DealsController < ApplicationController
  before_action :set_deal, only: [:show, :edit, :update, :destroy]
  before_action :set_pic, except: [:index, :edit]
  before_action :establish_connection, only: [:create, :update]

  # GET /deals
  # GET /deals.json
  def index
    @deals = Deal.all
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
    open_notification(@deal, self, current_user) if params[:opened]
  end

  # GET /deals/new
  def new
    @deal = Deal.new
  end

  # GET /deals/1/edit
  def edit
  end

  # POST /deals
  # POST /deals.json
  def create
    @deal = @pic.deals.new(deal_params)
    respond_to do |format|
      if @deal.save
        send_notification(@deal, self)
        format.html { redirect_to @pic.belongable.organization, notice: 'Deal was successfully created.' }
        format.json { render :show, status: :created, location: @deal }
      else
        format.html { render :new }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deals/1
  # PATCH/PUT /deals/1.json
  def update
    respond_to do |format|
      if @deal.update(deal_params)
        send_notification(@deal, self)
        format.html { redirect_to @pic ? @pic.belongable.organization : @deal, notice: 'Deal was successfully updated.' }
        format.json { render :show, status: :ok, location: @deal }
      else
        format.html { render :edit }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @deal.destroy
    send_notification(@deal, self)
    respond_to do |format|
      format.html { redirect_to deals_url, notice: 'Deal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def establish_connection
      @conn = Bunny.new
      @conn.start
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    def set_pic
      @pic = Pic.find_by(id: params[:pic_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deal_params
      params.require(:deal).permit(:pic_id, :name, :no_of_pcs, :employee_id, deadlines_attributes: [:id, :deadline, :reason, :cause_by, :_destroy])
    end
end
