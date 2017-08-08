class Api::V1::PropertiesController < ApiController
  def index
    keys = params.keys.collect { |k| k if k.end_with?("_id")}.compact
    if keys
      @propertys = Property.where(build_options(keys))
    else
      @propertys = Property.all
    end
    respond_to do |format|
      format.json { render json: @propertys }
    end
  end

  def show
    @property = Property.find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: @property || {} }
    end
  end

  private

  def build_options(keys)
    options = {}
    keys.each do |key|
      options[key.to_sym] = params[key]
    end
    options
  end
end
