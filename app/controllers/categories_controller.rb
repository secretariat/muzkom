class CategoriesController < ShopController

  before_filter :latest_products

  def show
    @order_by = order_by
    @subcategory = Subcategory.find params[:id]
    @products = @subcategory.products.visible.on_sale.order(:"#{@order_by}").page(params[:page])
    @current_category = @subcategory
    @brands = @subcategory.products.visible.on_sale.collect{|product| product.brand}.uniq
  end
  
end
