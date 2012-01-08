class CategoriesController < ShopController

  before_filter :latest_products
  
  def show
    @subcategory = Subcategory.find params[:id]
    @products = Product.where("subcategory_id = #{params[:id]}").page(params[:page]).per(10)
    @current_category = @subcategory
  end
  
end
