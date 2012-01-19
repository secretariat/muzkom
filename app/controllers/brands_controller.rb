class BrandsController < ShopController

  before_filter :latest_products
  
  def show
    @brand = Brand.find params[:id]
    @order_by = order_by
    unless params[:category_id].nil?
      @subcategory = @brand.subcategories.find(params[:category_id])
      @products = @brand.products.visible.by_subcategory(@subcategory).order(:"#{@order_by}").page(params[:page])
      @current_category = @subcategory
      render 'categories/show'
    else
      @products = @brand.products.visible.order(:"#{@order_by}").page(params[:page])
    end
  end
  
end