class ProductsController < ApplicationController
  def show
    if params[:id]
      product = Product.find(params[:id])
      sizes = product.sizes
      colors = product.colors
      custom_dye = product.custom_dye
      render json: {sizes: sizes, colors: colors, custom_dye: custom_dye}
    end
  end

  def price_ranges
    if params[:id]
      product = Product.find(params[:id])
      price_cents = 0
      product.price_ranges.each do |price_range|
        if params[:product_count].to_i.between?(price_range.from_quantity, price_range.to_quantity)
          price_cents = price_range.price_cents
        end
      end
      render json: {configurator_price: "#{product.currency} #{Money.new(price_cents, product.currency).to_i}"}
    end
  end

  def new_color
    @product = Product.find(params[:product_id])
    @deal = Deal.find(params[:deal_id])
  end

  def create_color
    @product = Product.find(params[:product_id])
    @deal = Deal.find(params[:deal_id])
    @pantone_colors = []
    if params[:pantone_colors]
      params[:pantone_colors].each_pair do |key, pantone_color|
        pantone_color = PantoneColor.new(key: key, name: pantone_color[:name], hex: pantone_color[:hex], pantone_code: pantone_color[:pantone_code])
        pantone_color.validate
        @pantone_colors << pantone_color
      end

      if @pantone_colors.all? { |color| color.valid? }
        @pantone_colors.each do |pantone_color|
          color = Color.new(name: pantone_color.name, hex: pantone_color.hex, pantone_code: pantone_color.pantone_code)
          color.save
          color_option = ColorOption.new(color_id: color.id, product_id: @product.id)
          color_option.save
        end
        redirect_to new_deal_job_request_path(@deal, product_id: @product.id)
      else
        render :new_color
      end

    else
      redirect_to new_deal_job_request_path(@deal)
    end
  end
end
