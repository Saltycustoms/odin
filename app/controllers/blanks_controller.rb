class BlanksController < ApplicationController
  before_action :set_blank, only: [:show, :edit, :update, :destroy]

  # GET /blanks
  # GET /blanks.json
  def index
    @blanks = Blank.all
  end

  # GET /blanks/1
  # GET /blanks/1.json
  def show
  end

  # GET /blanks/new
  def new
    @blank = Blank.new
  end

  # GET /blanks/1/edit
  def edit
  end

  # POST /blanks
  # POST /blanks.json
  def create
    @blank = Blank.new(blank_params)

    respond_to do |format|
      if @blank.save
        format.html { redirect_to @blank, notice: 'Blank was successfully created.' }
        format.json { render :show, status: :created, location: @blank }
      else
        format.html { render :new }
        format.json { render json: @blank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blanks/1
  # PATCH/PUT /blanks/1.json
  def update
    respond_to do |format|
      if @blank.update(blank_params)
        format.html { redirect_to @blank, notice: 'Blank was successfully updated.' }
        format.json { render :show, status: :ok, location: @blank }
      else
        format.html { render :edit }
        format.json { render json: @blank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blanks/1
  # DELETE /blanks/1.json
  def destroy
    @blank.destroy
    respond_to do |format|
      format.html { redirect_to blanks_url, notice: 'Blank was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blank
      @blank = Blank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blank_params
      params.require(:blank).permit(:price_cents, :name, :meta)
    end
end
