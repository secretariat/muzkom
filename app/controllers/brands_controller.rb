class BrandsController < ShopController

  before_filter :latest_products
  
  def show
    @brand = Brand.visible.find params[:id]
    @order_by = order_by
    unless params[:category_id].nil?
      @subcategory = @brand.subcategories.find(params[:category_id])
      if order_by == "price"
        @products =  @brand.products.by_subcategory(@subcategory).order_by_price.page(params[:page])
      else
        @products =  @brand.products.by_subcategory(@subcategory).order(:"#{@order_by}").page(params[:page])
      end
      @current_category = @subcategory
      render 'categories/show'
    else
      @products = @brand.products.visible.on_sale.order(:"#{@order_by}").page(params[:page])
    end
  end
  
  def withdrawn
    @products = Product.withdrawn.page(params[:page])
    @brand_list = Product.withdrawn.collect{|product| product.brand}.uniq
    @brand_list.sort!{|a, b| a.name.downcase <=> b.name.downcase}
  end
  
end