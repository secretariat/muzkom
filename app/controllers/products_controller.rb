class ProductsController < ShopController
  
  before_filter :latest_products
  
  def withdrawn
    @products = Product.withdrawn.where("brand_id = ?", params[:brand]).page(params[:page])
  
  end
  
  def show
    @product = Product.find params[:id]
    @similar = Product.similar(@product)
    @current_category = @product.subcategory
    @comment = ProductComment.new
  end
  
end
