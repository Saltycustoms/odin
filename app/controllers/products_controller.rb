class ProductsController < ActionController::API
  def show
    if params[:id]
      product = Product.find(params[:id])
      sizes = product.sizes
      colors = product.colors
      render json: {sizes: sizes, colors: colors}
    end
  end
end
