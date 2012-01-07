class ProductsController < ShopController
  def show
    @product = Product.find params[:id]
  end
end
