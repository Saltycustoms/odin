class ProductsController < ActionController::API
  def show
    if params[:id]
      product = Product.find(params[:id])
      sizes = product.sizes
      colors = product.colors
      render json: {sizes: sizes, colors: colors}
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
end
