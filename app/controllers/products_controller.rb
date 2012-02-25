class ProductsController < ShopController
  
  before_filter :latest_products
  
  def withdrawn
    @products = Product.withdrawn.where("brand_id = ?", params[:brand]).page(params[:page])
    @brand = Brand.find params[:brand]
  end
  
  def show
    @product = Product.find params[:id]
    @similar = Product.similar(@product)
    @current_category = @product.subcategory
    @comment = ProductComment.new
    @banners_left = Placement.find(5).banners.order(:position)
    @banners_right = Placement.find(6).banners.order(:position)
  end
  
end
