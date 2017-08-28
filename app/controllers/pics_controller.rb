class PicsController < ApplicationController
  before_action :authorize_user, only: [:new, :edit, :create, :update, :destroy]

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
    params.require(:pic).permit(:belongable_id, :belongable_type, :name, :tel, :title, :email)
  end

  def authorize_user
    if !current_user.has_any_role? :admin, :apparel_consultant, :director
      redirect_to request.referrer ? request.referrer : root_path, notice: "You are not authorized."
    end
  end
end
