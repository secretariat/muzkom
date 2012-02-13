class CategoriesController < ShopController

  before_filter :latest_products
  before_filter :list_brands

  def show
    @order_by = order_by
    @subcategory = Subcategory.find params[:id]
    @products = @subcategory.products.on_sale.order(:"#{@order_by}").page(params[:page])
    @current_category = @subcategory
  end
  
  private
  
  def list_brands 
    @brand_list = Brand.where("id in (select distinct brand_id from products where subcategory_id=#{params[:id]} and visibility=true)").order(:name)
  end
  
end
