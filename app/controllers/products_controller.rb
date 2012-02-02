class ProductsController < ShopController
  
#  before_filter :list_brands, :only=>[:index]
  before_filter :latest_products
  
  def index
    @products = Product.withdrawn.page(params[:page])
    @brand_list = @products.collect{|product| product.brand}.uniq
  end
  
  def show
    @product = Product.find params[:id]
    @similar = Product.similar(@product)
    @current_category = @product.subcategory
    @comment = Comment.new
  end
  
  private 
  
  def list_brands 
    @brand_list = Brand.where("id in (select distinct brand_id from products where subcategory_id=#{params[:id]} and visibility=0)").order(:name)
  end
end
