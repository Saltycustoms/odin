class OrganizationsController < ApplicationController
  before_action :authorize_user, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    @q = Organization.ransack(params[:q])
    @organizations = @q.result.page(params[:page])
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    @department = @organization.departments.take
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
    @organization.build_address
  end

  # GET /organizations/1/edit
  def edit
    @organization.build_address if @organization.address.nil?
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    @organization.tag_list = organization_params[:tag_list]

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    # Update tags
    @organization.tag_list = organization_params[:tag_list]

    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :description, :industry, :tag_list,
      address_attributes: [:name, :address1, :address2, :city, :postal_code, :country_code, :state, :_destroy, :id])
    end

    def authorize_user
      if !current_user.has_any_role? :admin, :apparel_consultant, :director
        redirect_to request.referrer ? request.referrer : root_path, notice: "You are not authorized."
      end
    end
end
