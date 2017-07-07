class PicsController < ApplicationController
  def create
    @organization = Organization.find(params[:organization_id])
    @pic = Pic.new(pic_params)

    if @pic.save
      redirect_to @organization
    else
      @organizations = Organization.all
      render "organizations/show"
    end
  end

  def pic_params
    params.require(:pic).permit(:belongable_id, :belongable_type, :name, :tel, :title)
  end
end
