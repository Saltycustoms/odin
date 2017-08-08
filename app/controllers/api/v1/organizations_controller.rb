class Api::V1::OrganizationsController < ApiController
  def index
    @organizations = Organization.all
    respond_to do |format|
      format.json { render json: @organizations }
    end
  end

  def show
    @organization = Organization.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @organization || {} }
    end
  end
end
