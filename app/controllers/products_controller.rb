class ProductsController < ShopController
  
#  before_filter :list_brands, :only=>[:index]
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
  
  private 
  
  def list_brands 
    @brand_list = Brand.where("id in (select distinct brand_id from products where subcategory_id=#{params[:id]} and visibility=0)").order(:name)
  end
end
