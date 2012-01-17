class CategoriesController < ShopController

  before_filter :latest_products
  
  def show
    list_brands
    @subcategory = Subcategory.find params[:id]
    @products = Product.where("subcategory_id = #{params[:id]}").page(params[:page]).per(10)
    @current_category = @subcategory
  end
  
  def list_brands 
    @brand_list = Brand.where("id in (select distinct brand_id from products where subcategory_id=#{params[:id]})").order(:name)
  end
  
end
