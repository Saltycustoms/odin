class PrintDetailsController < ApplicationController
  before_action :authorize_user, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_print_detail, only: [:show, :edit, :update, :destroy]

  # GET /print_details
  # GET /print_details.json
  def index
    @print_details = PrintDetail.all
  end

  # GET /print_details/1
  # GET /print_details/1.json
  def show
  end

  # GET /print_details/new
  def new
    @print_detail = PrintDetail.new
  end

  # GET /print_details/1/edit
  def edit
  end

  # POST /print_details
  # POST /print_details.json
  def create
    @print_detail = PrintDetail.new(print_detail_params)

    respond_to do |format|
      if @print_detail.save
        format.html { redirect_to @print_detail, notice: 'Print detail was successfully created.' }
        format.json { render :show, status: :created, location: @print_detail }
      else
        format.html { render :new }
        format.json { render json: @print_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /print_details/1
  # PATCH/PUT /print_details/1.json
  def update
    respond_to do |format|
      if @print_detail.update(print_detail_params)
        format.html { redirect_to @print_detail, notice: 'Print detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @print_detail }
      else
        format.html { render :edit }
        format.json { render json: @print_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /print_details/1
  # DELETE /print_details/1.json
  def destroy
    @print_detail.destroy
    respond_to do |format|
      format.html { redirect_to print_details_url, notice: 'Print detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_print_detail
      @print_detail = PrintDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def print_detail_params
      params.require(:print_detail).permit(:job_request_id, :position, :block, :color_count, :print_method, :attachment_data)
    end

    def authorize_user
      if !current_user.has_any_role? :admin, :apparel_consultant, :director
        redirect_to request.referrer ? request.referrer : root_path, notice: "You are not authorized."
      end
    end
end
