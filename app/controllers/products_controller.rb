class ProductsController < ShopController
  
  def show
    @product = Product.find params[:id]
    @similar = Product.similar(@product)
    @current_category = @product.subcategory
  end
  
end
